import Testing
import Foundation

/// Unit tests for verifying .gitignore patterns
@Suite("Gitignore Tests")
struct GitignoreTests {
    
    /// Test that .gitignore file exists and contains expected patterns
    @Test(".gitignore file contains SwiftPM build artifacts pattern")
    func gitignoreContainsBuildArtifacts() throws {
        // Given: Path to .gitignore file
        let gitignorePath = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent(".gitignore")
        
        // When: Reading .gitignore contents
        let contents = try String(contentsOf: gitignorePath, encoding: .utf8)
        
        // Then: It should contain .build/ pattern for SwiftPM artifacts
        #expect(contents.contains(".build/"),
                ".gitignore should contain '.build/' to ignore SwiftPM build artifacts")
    }
    
    @Test(".gitignore file contains .DS_Store pattern")
    func gitignoreContainsDSStore() throws {
        // Given: Path to .gitignore file
        let gitignorePath = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent(".gitignore")
        
        // When: Reading .gitignore contents
        let contents = try String(contentsOf: gitignorePath, encoding: .utf8)
        
        // Then: It should contain .DS_Store pattern
        #expect(contents.contains(".DS_Store"),
                ".gitignore should contain '.DS_Store' to ignore macOS system files")
    }
    
    @Test("Git ignores .build directory")
    func gitIgnoresBuildDirectory() throws {
        // Given: The .build directory path
        let buildDirPath = ".build/"
        
        // When: Checking if git would ignore this directory
        let isIgnored = try checkIfGitIgnores(path: buildDirPath)
        
        // Then: The directory should be ignored
        #expect(isIgnored,
                ".build/ directory should be ignored by git (SwiftPM build artifacts)")
    }
    
    @Test("Git ignores .DS_Store files")
    func gitIgnoresDSStore() throws {
        // Given: A .DS_Store file path
        let dsStorePath = ".DS_Store"
        
        // When: Checking if git would ignore this file
        let isIgnored = try checkIfGitIgnores(path: dsStorePath)
        
        // Then: The file should be ignored
        #expect(isIgnored,
                ".DS_Store files should be ignored by git")
    }
    
    @Test("Git ignores .DS_Store files in subdirectories")
    func gitIgnoresDSStoreInSubdirectories() throws {
        // Given: A .DS_Store file in a subdirectory
        let dsStorePath = "Sources/SwiftUIPlayground/.DS_Store"
        
        // When: Checking if git would ignore this file
        let isIgnored = try checkIfGitIgnores(path: dsStorePath)
        
        // Then: The file should be ignored
        #expect(isIgnored,
                ".DS_Store files in subdirectories should be ignored by git")
    }
    
    // MARK: - Helper Methods
    
    /// Check if a given path would be ignored by git
    /// - Parameter path: The file path to check (relative to repository root)
    /// - Returns: true if the path is ignored by git, false otherwise
    private func checkIfGitIgnores(path: String) throws -> Bool {
        let repoRoot = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        
        let process = Process()
        process.currentDirectoryURL = repoRoot
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["git", "check-ignore", "-q", path]
        
        // Redirect output to avoid console noise
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        try process.run()
        process.waitUntilExit()
        
        // git check-ignore returns 0 if the path is ignored, 1 if not
        return process.terminationStatus == 0
    }
}
