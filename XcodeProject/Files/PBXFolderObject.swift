import Foundation

public class PBXFolderObject: PBXFileObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        self._children = ReferenceGroup(rawValue["children"] as? [String])
        super.init(id, rawValue)
    }

    public override var path: String? {
        (self.rawValue["name"] as? String) ?? (super.path)
    }

    @ReferenceGroup public var children: [String]?

    func resolveReferences(using objects: [String: PBXObject]) {
        self._children.resolveReferences(using: objects)
    }
}

public extension PBXFolderObject {
    var files: [PBXFileObject]? {
        self.$children?.compactMap { $0 as? PBXFileObject }
    }
}
