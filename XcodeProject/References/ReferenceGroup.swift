import Foundation

@propertyWrapper
public final class ReferenceGroup: Referencing {
    public let wrappedValue: [String]?

    public private(set) var projectedValue: [PBXObject]?

    public init(_ wrappedValue: [String]?) {
        self.wrappedValue = wrappedValue
    }

    func resolveReferences(using objects: [String: PBXObject]) {
        self.projectedValue = self.wrappedValue?.map { objects[$0]! }
    }
}
