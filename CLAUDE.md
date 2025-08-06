# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GetUpPlease is a dual-platform iOS/watchOS SwiftUI application. The project contains two main targets:
- `GetUpPlease`: iOS app target 
- `GetUpPlease Watch App`: watchOS companion app target

Both apps currently display a minimal "Hello, world!" interface and are in early development stage.

## Architecture

### Project Structure
- `GetUpPlease/`: iOS app source code
- `GetUpPlease Watch App/`: watchOS app source code  
- `GetUpPleaseTests/`: Unit tests for iOS app
- `GetUpPlease Watch AppTests/`: Unit tests for watchOS app
- `GetUpPleaseUITests/`: UI tests for iOS app
- `GetUpPlease Watch AppUITests/`: UI tests for watchOS app

### Key Files
- App entry points: `GetUpPleaseApp.swift` in each target directory
- Main views: `ContentView.swift` in each target directory
- Both targets use SwiftUI framework with standard app lifecycle

## Development Commands

### Building
```bash
# Build iOS app
xcodebuild -project GetUpPlease.xcodeproj -scheme GetUpPlease -destination 'platform=iOS Simulator,name=iPhone 15' build

# Build watchOS app  
xcodebuild -project GetUpPlease.xcodeproj -scheme 'GetUpPlease Watch App' -destination 'platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)' build

# Build all targets
xcodebuild -project GetUpPlease.xcodeproj -alltargets build
```

### Testing
```bash
# Run iOS unit tests
xcodebuild test -project GetUpPlease.xcodeproj -scheme GetUpPlease -destination 'platform=iOS Simulator,name=iPhone 15'

# Run watchOS unit tests
xcodebuild test -project GetUpPlease.xcodeproj -scheme 'GetUpPlease Watch App' -destination 'platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)'

# Run UI tests
xcodebuild test -project GetUpPlease.xcodeproj -scheme GetUpPlease -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:GetUpPleaseUITests
```

## Testing Framework

The project uses Swift's new `Testing` framework (not XCTest). Test files import `Testing` and use `@Test` attribute for test methods with `#expect(...)` for assertions.

## Development Notes

- Project uses Xcode's modern project format (objectVersion = 77)
- SwiftUI previews are available via `#Preview` macro
- Both iOS and watchOS targets share similar basic structure but are separate codebases
- Asset catalogs are configured for both platforms with appropriate app icons and accent colors