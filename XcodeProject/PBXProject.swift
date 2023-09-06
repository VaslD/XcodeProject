import Foundation

public final class PBXProject: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXProject" else { return nil }
        self._mainGroup = Reference(rawValue["mainGroup"] as? String)
        self._productsGroup = Reference(rawValue["productRefGroup"] as? String)
        self._targets = ReferenceGroup(rawValue["targets"] as? [String])
        self._buildConfigurations = Reference(rawValue["buildConfigurationList"] as? String)
        super.init(id, rawValue)
    }

    @Reference public var mainGroup: String?

    @Reference public var productsGroup: String?

    @ReferenceGroup public var targets: [String]?

    @Reference public var buildConfigurations: String?

    public var developmentRegion: String? {
        self.rawValue["developmentRegion"] as? String
    }

    public var knownRegions: [String]? {
        self.rawValue["knownRegions"] as? [String]
    }

    public var attributes: [String: Any]? {
        self.rawValue["attributes"] as? [String: Any]
    }

    func resolveReferences(using objects: [String: PBXObject]) {
        self._mainGroup.resolveReferences(using: objects)
        self._productsGroup.resolveReferences(using: objects)
        self._targets.resolveReferences(using: objects)
        self._buildConfigurations.resolveReferences(using: objects)
    }
}

public extension PBXProject {
    var fileRoot: PBXGroup? {
        self.$mainGroup as? PBXGroup
    }
    
    var nativeTargets: [PBXNativeTarget] {
        self.$targets?.compactMap { $0 as? PBXNativeTarget } ?? []
    }
}
