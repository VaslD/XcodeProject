import Foundation

public final class XCVersionGroup: PBXFolderObject {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "XCVersionGroup" else { return nil }
        self._currentVersion = Reference(rawValue["currentVersion"] as? String)
        super.init(id, rawValue)
    }

    public var groupType: String? {
        self.rawValue["versionGroupType"] as? String
    }

    @Reference public var currentVersion: String?

    override func resolveReferences(using objects: [String: PBXObject]) {
        super.resolveReferences(using: objects)
        self._currentVersion.resolveReferences(using: objects)
    }
}
