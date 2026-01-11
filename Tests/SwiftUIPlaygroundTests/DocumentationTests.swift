import Testing
import Foundation

/// Unit tests to verify project documentation files (README.md and WARP.md)
@Suite("Documentation Tests")
struct DocumentationTests {
    
    private var projectRoot: URL {
        // Navigate up from the test bundle to find the project root
        let currentFile = URL(fileURLWithPath: #file)
        return currentFile
            .deletingLastPathComponent() // Tests/SwiftUIPlaygroundTests
            .deletingLastPathComponent() // Tests
            .deletingLastPathComponent() // Project root
    }
    
    // MARK: - README.md Tests
    
    /// Test 1: Verify that README.md exists and is initially empty
    @Test("README.md exists and is initially empty")
    func readmeExistsAndIsEmpty() throws {
        let readmePath = projectRoot.appendingPathComponent("README.md")
        
        // Verify file exists
        #expect(
            FileManager.default.fileExists(atPath: readmePath.path),
            "README.md should exist in the project root"
        )
        
        // Verify file is empty (only whitespace/newlines allowed)
        let content = try String(contentsOf: readmePath, encoding: .utf8)
        #expect(
            content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            "README.md should be initially empty"
        )
    }
    
    // MARK: - WARP.md Tests
    
    /// Test 2: Check that WARP.md contains guidance text with required sections
    @Test("WARP.md exists with required sections")
    func warpMdExistsWithRequiredSections() throws {
        let warpPath = projectRoot.appendingPathComponent("WARP.md")
        
        // Verify file exists
        #expect(
            FileManager.default.fileExists(atPath: warpPath.path),
            "WARP.md should exist in the project root"
        )
        
        // Read content
        let content = try String(contentsOf: warpPath, encoding: .utf8)
        
        // Verify it's not empty
        #expect(
            !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            "WARP.md should contain guidance text"
        )
        
        // Verify required sections exist
        #expect(
            content.contains("## Development Commands"),
            "WARP.md should contain 'Development Commands' section"
        )
        
        #expect(
            content.contains("## Architecture Guidelines"),
            "WARP.md should contain 'Architecture Guidelines' section"
        )
        
        #expect(
            content.contains("## Platform Considerations"),
            "WARP.md should contain 'Platform Considerations' section"
        )
    }
    
    /// Test 3: Validate code block formatting with build and test commands
    @Test("WARP.md contains build and test commands")
    func warpMdContainsBuildAndTestCommands() throws {
        let warpPath = projectRoot.appendingPathComponent("WARP.md")
        let content = try String(contentsOf: warpPath, encoding: .utf8)
        
        // Verify code blocks exist
        #expect(
            content.contains("```bash"),
            "WARP.md should contain bash code blocks"
        )
        
        // Verify xcodebuild commands
        #expect(
            content.contains("xcodebuild"),
            "WARP.md should contain xcodebuild commands"
        )
        
        #expect(
            content.contains("xcodebuild test"),
            "WARP.md should document test commands"
        )
        
        #expect(
            content.contains("xcodebuild -scheme"),
            "WARP.md should document scheme-based build commands"
        )
        
        // Verify Swift Package Manager commands
        #expect(
            content.contains("swift build"),
            "WARP.md should document swift build command"
        )
        
        #expect(
            content.contains("swift test"),
            "WARP.md should document swift test command"
        )
        
        // Verify proper code block closure
        let codeBlockStarts = content.components(separatedBy: "```bash").count - 1
        let codeBlockEnds = content.components(separatedBy: "```").count - 1
        #expect(
            codeBlockStarts * 2 == codeBlockEnds, // Each block has opening and closing
            "All code blocks should be properly closed"
        )
    }
    
    /// Test 4: Ensure SwiftUI best practices are documented
    @Test("WARP.md contains SwiftUI best practices")
    func warpMdContainsSwiftUIBestPractices() throws {
        let warpPath = projectRoot.appendingPathComponent("WARP.md")
        let content = try String(contentsOf: warpPath, encoding: .utf8)
        
        // Test state management recommendations
        #expect(
            content.contains("@State"),
            "WARP.md should document @State usage"
        )
        
        #expect(
            content.contains("@StateObject"),
            "WARP.md should document @StateObject usage"
        )
        
        #expect(
            content.contains("@ObservedObject"),
            "WARP.md should document @ObservedObject usage"
        )
        
        #expect(
            content.contains("@EnvironmentObject"),
            "WARP.md should document @EnvironmentObject usage"
        )
        
        // Test view composition recommendations
        #expect(
            content.contains("View Composition") || content.contains("view composition"),
            "WARP.md should discuss view composition"
        )
        
        #expect(
            content.contains("reusable components") || content.contains("reusable"),
            "WARP.md should encourage reusable components"
        )
        
        // Test data flow patterns
        #expect(
            content.contains("data flow") || content.contains("Data Flow"),
            "WARP.md should discuss data flow patterns"
        )
        
        // Test preview providers
        #expect(
            content.contains("PreviewProvider") || content.contains("preview"),
            "WARP.md should mention PreviewProvider or previews"
        )
    }
    
    /// Test 5: Validate platform-specific and SwiftUI-specific notes
    @Test("WARP.md contains platform and SwiftUI-specific notes")
    func warpMdContainsPlatformAndSwiftUISpecificNotes() throws {
        let warpPath = projectRoot.appendingPathComponent("WARP.md")
        let content = try String(contentsOf: warpPath, encoding: .utf8)
        
        // Check for SwiftUI-Specific Notes section
        #expect(
            content.contains("SwiftUI-Specific Notes") || content.contains("SwiftUI Patterns"),
            "WARP.md should have SwiftUI-specific guidance"
        )
        
        // Verify struct vs class guidance
        #expect(
            content.contains("struct") && content.contains("view"),
            "WARP.md should discuss struct views"
        )
        
        // Verify view lifecycle notes
        #expect(
            content.contains("body") || content.contains("lifecycle"),
            "WARP.md should discuss view body/lifecycle"
        )
        
        // Check platform-specific guidance
        #expect(
            content.contains("iOS") && content.contains("macOS"),
            "WARP.md should mention both iOS and macOS platforms"
        )
        
        #expect(
            content.contains("#if os(iOS)") || content.contains("#if os(macOS)"),
            "WARP.md should document platform-specific compilation"
        )
        
        // Verify API availability guidance
        #expect(
            content.contains("@available") || content.contains("availability"),
            "WARP.md should mention API availability checks"
        )
        
        // Verify async operation guidance
        #expect(
            content.contains(".task") || content.contains("async"),
            "WARP.md should document async operations in SwiftUI"
        )
        
        // Verify performance considerations
        #expect(
            content.contains("computation") || content.contains("performance"),
            "WARP.md should include performance considerations"
        )
    }
}
