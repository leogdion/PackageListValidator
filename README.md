# PackageListValidator

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@SwiftPackageIndex-blue.svg?style=flat)](http://twitter.com/SwiftPackageIndex)
![GitHub](https://img.shields.io/github/license/SwiftPackageIndex/PackageListValidator)
![GitHub issues](https://img.shields.io/github/issues/SwiftPackageIndex/PackageListValidator)

[![macOS](https://github.com/SwiftPackageIndex/PackageListValidator/workflows/macOS/badge.svg)](https://github.com/SwiftPackageIndex/PackageListValidator/actions?query=workflow%3AmacOS)
[![ubuntu](https://github.com/SwiftPackageIndex/PackageListValidator/workflows/ubuntu/badge.svg)](https://github.com/SwiftPackageIndex/PackageListValidator/actions?query=workflow%3Aubuntu)
[![arm](https://github.com/SwiftPackageIndex/PackageListValidator/workflows/arm/badge.svg)](https://github.com/SwiftPackageIndex/PackageListValidator/actions?query=workflow%3Aarm)

[![Codecov](https://img.shields.io/codecov/c/github/SwiftPackageIndex/PackageListValidator)](https://codecov.io/gh/SwiftPackageIndex/PackageListValidator)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/SwiftPackageIndex/PackageListValidator)](https://www.codefactor.io/repository/github/SwiftPackageIndex/PackageListValidator)
[![codebeat badge](https://codebeat.co/badges/4f86fb90-f8de-40c5-ab63-e6069cde5002)](https://codebeat.co/projects/github-com-SwiftPackageIndex-PackageListValidator-master)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/SwiftPackageIndex/PackageListValidator)](https://codeclimate.com/github/SwiftPackageIndex/PackageListValidator)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/SwiftPackageIndex/PackageListValidator?label=debt)](https://codeclimate.com/github/SwiftPackageIndex/PackageListValidator)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/SwiftPackageIndex/PackageListValidator)](https://codeclimate.com/github/SwiftPackageIndex/PackageListValidator)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

--- 

Official Package List Validator for [Swift Package Index](https://swiftpackageindex.com)

## About 

Before each package is added to Swift Package Index, the package list must verified for correctness. These verifications come in two forms: the overall list and each package.

As far as the overall list, it must:

* Contain no duplicates 
* Sorted in alphabetical order
* Correct url format of each package (i.e.  end in _.git_)

For each package to valid, it must:

* Have a valid and accessible (i.e. via public repo) `Package.swift` file
* Contains one valid product (library or executable)

This application is useful for those, who are interested contributing their own package to the Swift Package Index or wish to contribute to this project.

## Installation

There are two methods to run this application:

* run remotely via swift-sh and curl
* run locally via mint installation

### Remote via Swift-Sh

### Locally via Mint Installation

## Usage

```
USAGE: swiftpmls <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  all                     Verify every package in the JSON file.
  mine                    Verify the package in the directory specified or the
                          current directory.
  diff                    Verify only packages which are not contained in the
                          current master list.
```

Once you are able to run the application there are three subcommands available:

* **mine** - verify the Swift package in the directory specified
* **all** - verify all the Swift packages in the `packages.json` specified
* **diff** - verify only Swift packages in the `packages.json` specified which are not contained in the master `packages.json`

### Mine - verifying your Swift Package

```
OVERVIEW: Verify the package in the directory specified or the current
directory.
USAGE: swiftpmls mine [<directory>]

ARGUMENTS:
  <directory>             The directory to verify if the Swift package is
                          valid. 

OPTIONS:
  -h, --help              Show help information.
 ```

### All - verifying all Swift Packages

```
OVERVIEW: Verify every package in the JSON file.
USAGE: swiftpmls diff [<path>]

ARGUMENTS:
  <path>                  Path to the JSON file containing the repository list.
                          (default: packages.json)

OPTIONS:
  -h, --help              Show help information.
 ```
 
### Diff - verifying new Swift Packages

```
OVERVIEW: Verify only packages which are not contained in the current master
list.
USAGE: swiftpmls all [<path>]

ARGUMENTS:
  <path>                  Path to the JSON file containing the repository list
                          (default: packages.json)

OPTIONS:
  -h, --help              Show help information.
 ```

## How it Works

As stated above the validator first verifies the overall list and then verifies each Package individually. When validating the overall list, each url must be valid, the list can not contain duplicates, and each repository must be in alphabetical order.

### Validating the List

In order to verify the list, the `packages.json` specified must be in a valid JSON format (i.e. Array of URLs). Therefore if the application cannot read the data at the path or use the `JSONDecoder` to decode the file `decoder.decode([URL].self, from: data)`, then the list will be deemed invalid.

Having decoded the `packages.json` file, the next part of the process is validating the list overall.

#### URL Verification

In order to make sure the list does not contain duplicates based on various scheme/protocol and extension variations, a standard repository url format has been decided:

```
https://github.com/owner/repositoryName.git
```

If the url does not follow this format, the url is marked as invalid.

### List Order

Next, each url must be in the correct alphabetical order. This is done by transforming each url to it's lowercase format and using the less than operator `<`:

```
    let sortedUrls = urls.sorted {
      $0.absoluteString.lowercased() < $1.absoluteString.lowercased()
    }
```

Once the sorted is completed, the application then compares the specified `packages.json` with the sorted list. If there are any differences, the list is determined to be invalid.

### List Duplicates

In order to make sure each url is unique (i.e. no case variants), the application makes a lowercase absolute URL string from URL and counts instances for each lowercase url in the list:

```
      URL(string: $0.element.absoluteString.lowercased())!
              }.mapValues { $0.map { $0.offset } }.filter { $0.value.count > 1 }.keys)
```

This creates a list of URLs which more than one value. If there are URLs with duplicates, it is marked as invalid.

### Validating Each Repository

To determine whether a package is valid, it must contain a valid Package.swift in its default branch. This means the application needs to:

* Find the url pattern for downloads
* Find the default branch of the repository
* Download the Package.swift file from the repository
* Count the number products in the Swift Package

#### Determining the URL

The first step in order to make sure a Swift package is valid is downloading the `Package.swift` file of the package. What this means luckily, is that the application does not need to clone the entire repo. Based on the determined host of the repository, the application can transform the repository url to the raw url of the Package.swift of the repository. ** At this time, the validation tool only works with GitHub, however if you are using another support can be easily added. ** Therefore, with GitHub, we can use `https://raw.githubusercontent.com` to determine the url of `Package.swift` in the repository.

However, the missing part of the url is the default branch of the repository. Therefore, this is the larger challenge of the application.

#### Determining the Default Branch

By default, GitHub uses `master` as the default branch of every repository. However there are many cases, where `master` is not the default branch. Therefore the application needs to call the GitHub API to find that setting. However, in order to make sure the GitHub API Limit is not reached, there are few ways the application avoids this call:

* Test for the `Package.swift` in branch `master`
* Do not make this call in `all` since that call be as many 3000 repositories

In order to allow the GitHub API call, the `GITHUB_API_TOKEN` and `GITHUB_API_USERNAME` must be as environment variables, such as:

```
GITHUB_API_TOKEN=abc123 GITHUB_API_USERNAME=username@github swiftpmls diff 
```

If the url cannot be deciphered, the package is marked as invalid. Otherwise, the next step is downloading the Swift package.

#### Validating the Swift Package

Once the url is determined, the application downloads the `Package.swift` file. Once the file is downloaded to a tempoary directory, the application runs `swift pacakge dump-package` to get the structure of the Swift package.

A simplified `Codable` version of the JSON dumped is decoded from standard output. If the dump reveals there is at least one valid product, then the package is valid.

### Code Documentation

[Documentation Here](/Documentation/Reference/README.md)

## Built Using

* PromiseKit
* Swift Argument Parser

## Authors 

* leo
* dave

