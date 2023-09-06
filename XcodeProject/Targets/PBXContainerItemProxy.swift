import Foundation

public final class PBXContainerItemProxy: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXContainerItemProxy" else { return nil }
        self._portal = Reference(rawValue["containerPortal"] as? String)
        self._remote = Reference(rawValue["remoteGlobalIDString"] as? String)
        super.init(id, rawValue)
    }

    @Reference public var portal: String?

    @Reference public var remote: String?

    public var remoteInfo: String? {
        self.rawValue["remoteInfo"] as? String
    }

    public var type: Int? {
        (self.rawValue["proxyType"] as? String).flatMap { Int($0) }
    }

    func resolveReferences(using objects: [String: PBXObject]) {
        self._portal.resolveReferences(using: objects)
        self._remote.resolveReferences(using: objects)
    }
}
