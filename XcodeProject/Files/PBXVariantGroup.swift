import Foundation

public final class PBXVariantGroup: PBXFolderObject {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXVariantGroup" else { return nil }
        super.init(id, rawValue)
    }
}
