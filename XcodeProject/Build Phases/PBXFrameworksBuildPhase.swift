import Foundation

public final class PBXFrameworksBuildPhase: PBXBuildPhase {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXFrameworksBuildPhase" else { return nil }
        super.init(id, rawValue)
    }
    
    override func resolveReferences(using objects: [String: PBXObject]) {
        super.resolveReferences(using: objects)
        guard let files = self.$files else { return }
        assert(files is [PBXBuildFile], "FIXME: PBXHeadersBuildPhase contains unknown reference.")
    }
}

public extension PBXFrameworksBuildPhase {
    var fileReferences: [PBXFileReference] {
        self.$files.flatMap { ($0 as! [PBXBuildFile]) }?.compactMap { $0.fileReference } ?? []
    }
}
