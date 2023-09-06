import Foundation

public final class PBXCopyFilesBuildPhase: PBXBuildPhase {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXCopyFilesBuildPhase" else { return nil }
        super.init(id, rawValue)
    }

    public var destinationPath: String? {
        self.rawValue["dstPath"] as? String
    }

    public var destinationSubfolderPolicy: Int? {
        (self.rawValue["dstSubfolderSpec"] as? String).flatMap { Int($0) }
    }
}
