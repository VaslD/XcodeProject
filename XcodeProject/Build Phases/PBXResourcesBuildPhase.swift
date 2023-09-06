import Foundation

public final class PBXResourcesBuildPhase: PBXBuildPhase {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXResourcesBuildPhase" else { return nil }
        super.init(id, rawValue)
    }
    
    override func resolveReferences(using objects: [String: PBXObject]) {
        super.resolveReferences(using: objects)
        guard let files = self.$files else { return }
        assert(files is [PBXBuildFile], "FIXME: PBXHeadersBuildPhase contains unknown reference.")
    }
}

public extension PBXResourcesBuildPhase {
    var fileReferences: [PBXFileReference] {
        self.$files.flatMap { ($0 as! [PBXBuildFile]) }?.compactMap(\.fileReference) ?? []
    }
}
