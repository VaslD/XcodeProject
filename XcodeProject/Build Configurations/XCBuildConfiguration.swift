import Foundation

public final class XCBuildConfiguration: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "XCBuildConfiguration" else { return nil }
        self._baseConfigurationReference = Reference(rawValue["baseConfigurationReference"] as? String)
        super.init(id, rawValue)
    }
    
    public var name: String? {
        self.rawValue["name"] as? String
    }
    
    @Reference public var baseConfigurationReference: String?

    public var settings: [String: Any]? {
        self.rawValue["buildSettings"] as? [String: Any]
    }
    
    func resolveReferences(using objects: [String : PBXObject]) {
        self._baseConfigurationReference.resolveReferences(using: objects)
    }
}

public extension XCBuildConfiguration {
    var baseConfiguration: PBXFileReference? {
        self.$baseConfigurationReference as? PBXFileReference
    }
}
