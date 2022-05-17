#!/usr/bin/env bash

readonly SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -rf "$SCRIPTS_DIR/FrameworkBuilds" 2> /dev/null

function buildFramework()
{
  xcodebuild archive \
    -scheme "$1" \
    -sdk iphoneos \
    -archivePath "$SCRIPTS_DIR/FrameworkBuilds/archives/ios_devices.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

  xcodebuild archive \
    -scheme "$1" \
    -sdk iphonesimulator \
    -archivePath "$SCRIPTS_DIR/FrameworkBuilds/archives/ios_simulators.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

  xcodebuild -create-xcframework \
    -framework "$SCRIPTS_DIR/FrameworkBuilds/archives/ios_devices.xcarchive/Products/Library/Frameworks/$1.framework" \
    -framework "$SCRIPTS_DIR/FrameworkBuilds/archives/ios_simulators.xcarchive/Products/Library/Frameworks/$1.framework" \
    -output "$SCRIPTS_DIR/$1.xcframework"

  cp -r "$SCRIPTS_DIR/$1.xcframework/ios-arm64/$1.framework/Headers" "$SCRIPTS_DIR/$1.xcframework/"
  find "$SCRIPTS_DIR/$1.xcframework/" -name "*.swiftinterface" -exec sed -i -e 's/SubscriptionsKit\.//g' {} \;
  rm -rf "$SCRIPTS_DIR/FrameworkBuilds" 2> /dev/null
}

buildFramework SubscriptionsKit
