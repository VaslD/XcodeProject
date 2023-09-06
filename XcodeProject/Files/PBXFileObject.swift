import Foundation

public class PBXFileObject: PBXObject {
    public var path: String? {
        self.rawValue["path"] as? String
    }
}
