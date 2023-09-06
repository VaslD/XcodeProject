import Foundation

public final class PBXTargetDependency: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXTargetDependency" else { return nil }
        self._target = Reference(rawValue["target"] as? String)
        self._proxy = Reference(rawValue["targetProxy"] as? String)
        super.init(id, rawValue)
    }

    @Reference public var target: String?

    @Reference public var proxy: String?

    func resolveReferences(using objects: [String: PBXObject]) {
        self._target.resolveReferences(using: objects)
        self._proxy.resolveReferences(using: objects)
    }
}
