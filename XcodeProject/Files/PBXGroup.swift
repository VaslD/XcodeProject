import Foundation

public final class PBXGroup: PBXFolderObject {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXGroup" else { return nil }
        super.init(id, rawValue)
    }
}
