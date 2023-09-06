import Foundation

public final class PBXHeadersBuildPhase: PBXBuildPhase {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXHeadersBuildPhase" else { return nil }
        super.init(id, rawValue)
    }

    override func resolveReferences(using objects: [String: PBXObject]) {
        super.resolveReferences(using: objects)
        guard let files = self.$files else { return }
        assert(files is [PBXBuildFile], "FIXME: PBXHeadersBuildPhase contains unknown reference.")
    }
}

public extension PBXHeadersBuildPhase {
    var fileReferences: [PBXFileReference] {
        self.$files.flatMap { ($0 as! [PBXBuildFile]) }?.compactMap(\.fileReference) ?? []
    }
}
