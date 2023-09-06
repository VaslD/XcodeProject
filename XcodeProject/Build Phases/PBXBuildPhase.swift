import Foundation

public class PBXBuildPhase: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        self._files = ReferenceGroup(rawValue["files"] as? [String])
        super.init(id, rawValue)
    }

    public var name: String? {
        self.rawValue["name"] as? String
    }

    public var actions: Int? {
        (self.rawValue["buildActionMask"] as? String).flatMap { Int($0) }
    }

    @ReferenceGroup public var files: [String]?

    public var runOnlyForDeploymentPostprocessing: Bool? {
        (self.rawValue["runOnlyForDeploymentPostprocessing"] as? String).flatMap { $0 == "1" }
    }

    func resolveReferences(using objects: [String: PBXObject]) {
        self._files.resolveReferences(using: objects)
    }
}
