import Foundation

@propertyWrapper
public final class Reference: Referencing {
    public let wrappedValue: String?

    public private(set) var projectedValue: PBXObject?

    public init(_ wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }

    func resolveReferences(using objects: [String: PBXObject]) {
        self.projectedValue = self.wrappedValue.flatMap { objects[$0]! }
    }
}
