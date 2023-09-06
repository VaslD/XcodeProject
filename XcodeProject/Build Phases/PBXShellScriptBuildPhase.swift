import Foundation

public final class PBXShellScriptBuildPhase: PBXBuildPhase {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXShellScriptBuildPhase" else { return nil }
        super.init(id, rawValue)
    }

    public var shell: String? {
        self.rawValue["shellPath"] as? String
    }

    public var script: String? {
        self.rawValue["shellScript"] as? String
    }

    public var logEnvironmentVariables: Bool? {
        (self.rawValue["showEnvVarsInLog"] as? String).flatMap { $0 == "1" }
    }

    public var inputFiles: [String]? {
        self.rawValue["inputFileListPaths"] as? [String]
    }

    public var outputFiles: [String]? {
        self.rawValue["outputFileListPaths"] as? [String]
    }
}
