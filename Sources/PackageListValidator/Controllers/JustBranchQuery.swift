import Foundation
import PromiseKit

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct JustBranchQuery : DefaultBranchQuery {
  let branchName : String
  func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void)) {
    completed(.success(self.branchName))
  }
  
  
}


struct FallbackBranchQuery : DefaultBranchQuery {
  let branchURL : (RepoSpecification) -> URL
  let queries : [DefaultBranchQuery]
  func defaultBranchName(forRepoName repo: String, withOwner owner: String, _ completed: @escaping ((Result<String, Error>) -> Void)) {
    let verifications = queries.map{ $0.defaultBranchName(forRepoName: repo, withOwner: owner).then{self.verifyBranch(
      RepoSpecification(repositoryName: repo, userName: owner, branchName: $0)
      )}}
    var current : Promise<String>?
    for promise in verifications {
      
      
      let newPromise : Promise<String>
      if let old = current {
        newPromise = old.recover({ (_)  in
          return promise
        })
      } else {
        newPromise = promise
      }
      current = newPromise
    }
    
    guard let promise = current else {
      completed(.failure(PMKError.emptySequence))
      return
    }
    
    promise.done {
      completed(.success($0))
    }.catch {
      completed(.failure($0))
    }
  }
  
  struct NotExistError : Error {
    
  }
  func verifyBranch(_ repoSpecs: RepoSpecification) -> Promise<String> {
    Promise { (resolver) in
      let url = self.branchURL(repoSpecs)
      let checkSession = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
       //request.timeoutInterval = 5.0 // Adjust to your needs

        let task = checkSession.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if let error = error {

            resolver.reject(error)
          }
            else if let httpResp: HTTPURLResponse = response as? HTTPURLResponse {
              if httpResp.statusCode == 200 {
                resolver.fulfill(repoSpecs.branchName)
              } else {
                resolver.reject(NotExistError.init())
              }
            } else {
              resolver.reject(NotExistError.init())
          }
        })

        task.resume()
    }
  }
}
