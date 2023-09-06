import Foundation

public final class PBXFileReference: PBXFileObject {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "PBXFileReference" else { return nil }
        super.init(id, rawValue)
    }

    public var fileType: String? {
        self.rawValue["lastKnownFileType"] as? String
    }

    public var encoding: String.Encoding? {
        (self.rawValue["fileEncoding"] as? String).flatMap { UInt($0) }.flatMap { String.Encoding(rawValue: $0) }
    }
}
