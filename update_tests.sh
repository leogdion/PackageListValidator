find Sources -type f -name '*.swift' | while read i; do
   FILENAME=$(basename  -- $i)
   FILENAME="${FILENAME%.*}"
   CLASSNAME=$FILENAME"Tests"
   DIRNAME=$(dirname $i)
   DESTDIRNAME=NewTests/$DIRNAME
   DESTFILE=$DESTDIRNAME/$CLASSNAME.swift
   mkdir -p $DESTDIRNAME
   echo "import PackageListValidator
#if !os(watchOS)
  import XCTest
  final class $CLASSNAME: XCTestCase {}
#endif" > $DESTFILE
done