import Foundation

public final class PBXSourcesBuildPhase: PBXBuildPhase {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXSourcesBuildPhase" else { return nil }
        super.init(id, rawValue)
    }
    
    override func resolveReferences(using objects: [String : PBXObject]) {
        super.resolveReferences(using: objects)
        guard let files = self.$files else { return }
        assert(files is [PBXBuildFile], "FIXME: PBXSourcesBuildPhase contains unknown reference.")
    }
}

public extension PBXSourcesBuildPhase {
    var fileReferences: [PBXFileReference] {
        self.$files.flatMap { ($0 as! [PBXBuildFile]) }?.compactMap { $0.fileReference } ?? []
    }
}
