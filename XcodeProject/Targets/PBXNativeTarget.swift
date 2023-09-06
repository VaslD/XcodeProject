import Foundation

public final class PBXNativeTarget: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXNativeTarget" else { return nil }
        self._dependencies = ReferenceGroup(rawValue["dependencies"] as? [String])
        self._buildPhases = ReferenceGroup(rawValue["buildPhases"] as? [String])
        self._buildConfigurationList = Reference(rawValue["buildConfigurationList"] as? String)
        super.init(id, rawValue)
    }

    public var name: String? {
        self.rawValue["name"] as? String
    }

    public var productName: String? {
        self.rawValue["productName"] as? String
    }

    public var productType: String? {
        self.rawValue["productType"] as? String
    }

    @ReferenceGroup public var dependencies: [String]?

    @ReferenceGroup public var buildPhases: [String]?

    @Reference public var buildConfigurationList: String?

    func resolveReferences(using objects: [String: PBXObject]) {
        self._dependencies.resolveReferences(using: objects)
        self._buildPhases.resolveReferences(using: objects)
        self._buildConfigurationList.resolveReferences(using: objects)
    }
}

public extension PBXNativeTarget {
    var buildConfigurations: XCConfigurationList? {
        self.$buildConfigurationList as? XCConfigurationList
    }
    
    var headersPhase: PBXHeadersBuildPhase? {
        self.$buildPhases?.first { $0 is PBXHeadersBuildPhase }.flatMap { ($0 as! PBXHeadersBuildPhase) }
    }
    
    var compileSourcesPhase: PBXSourcesBuildPhase? {
        self.$buildPhases?.first { $0 is PBXSourcesBuildPhase }.flatMap { ($0 as! PBXSourcesBuildPhase) }
    }
    
    var linkBinaryWithLibrariesPhase: PBXFrameworksBuildPhase? {
        self.$buildPhases?.first { $0 is PBXFrameworksBuildPhase }.flatMap { ($0 as! PBXFrameworksBuildPhase) }
    }
    
    var copyBundleResourcesPhase: PBXResourcesBuildPhase? {
        self.$buildPhases?.first { $0 is PBXResourcesBuildPhase }.flatMap { ($0 as! PBXResourcesBuildPhase) }
    }
}
