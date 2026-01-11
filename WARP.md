# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a SwiftUI playground repository for experimenting with SwiftUI views, components, and app architectures on macOS and iOS.

## Development Commands

### Building and Running
```bash
# Build the project
xcodebuild -scheme <SchemeName> -configuration Debug build

# Run tests
xcodebuild test -scheme <SchemeName> -destination 'platform=iOS Simulator,name=iPhone 15'

# Run tests for macOS
xcodebuild test -scheme <SchemeName> -destination 'platform=macOS'

# Clean build folder
xcodebuild clean -scheme <SchemeName>
```

### Swift Package Manager (if applicable)
```bash
# Build with SPM
swift build

# Run tests
swift test

# Generate Xcode project from Package.swift
swift package generate-xcodeproj
```

### Code Quality
```bash
# Format Swift code (if SwiftFormat is installed)
swiftformat .

# Lint code (if SwiftLint is installed)
swiftlint

# Fix auto-correctable issues
swiftlint --fix
```

## Architecture Guidelines

### SwiftUI Patterns

- **View Composition**: Break down complex views into smaller, reusable components
- **State Management**: Use `@State` for local view state, `@StateObject` for view-owned observable objects, `@ObservedObject` for passed-in observable objects, and `@EnvironmentObject` for shared app-wide state
- **Data Flow**: Follow unidirectional data flow - data flows down through parameters, events flow up through bindings and closures
- **Preview Providers**: Always include `PreviewProvider` for each view to enable Xcode canvas previews

### Project Structure Conventions

When organizing SwiftUI code:
- Group views by feature or screen
- Separate view models (`ObservableObject` classes) from views
- Keep reusable components in a dedicated `Components/` directory
- Place preview-specific code in `#if DEBUG` blocks to reduce release build size

### SwiftUI-Specific Notes

- Prefer `struct` views over `class` views (SwiftUI views should be value types)
- Use `.id()` modifier to force view recreation when identity needs to change
- Be mindful of view lifecycle - SwiftUI body is called frequently
- Avoid heavy computation in view body - use `@State` with `onChange` or computed properties in view models instead
- Use `.task { }` modifier for async operations that should start when view appears

## Platform Considerations

- Test on both iOS and macOS if building cross-platform
- Use `#if os(iOS)` / `#if os(macOS)` for platform-specific code
- Be aware of API availability - use `@available` attributes when needed
