import Foundation

public final class PBXBuildFile: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXBuildFile" else { return nil }
        self._file = Reference(rawValue["fileRef"] as? String)
        super.init(id, rawValue)
    }

    @Reference public var file: String?

    public var settings: [String: Any]? {
        self.rawValue["settings"] as? [String: Any]
    }
    
    func resolveReferences(using objects: [String : PBXObject]) {
        self._file.resolveReferences(using: objects)
    }
}

public extension PBXBuildFile {
    var fileReference: PBXFileReference? {
        self.$file as? PBXFileReference
    }
}
