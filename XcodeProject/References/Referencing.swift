import Foundation

protocol Referencing {
    func resolveReferences(using objects: [String: PBXObject])
}
