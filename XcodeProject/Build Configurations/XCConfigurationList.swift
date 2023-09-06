import Foundation

public final class XCConfigurationList: PBXObject, Referencing {
    public required init?(_ id: String, _ rawValue: [String: Any]) {
        guard (rawValue["isa"] as? String) == "XCConfigurationList" else { return nil }
        self._configurations = ReferenceGroup(rawValue["buildConfigurations"] as? [String])
        super.init(id, rawValue)
    }

    public var defaultConfigurationName: String? {
        self.rawValue["defaultConfigurationName"] as? String
    }

    public var defaultConfigurationVisible: Bool? {
        (self.rawValue["defaultConfigurationIsVisible"] as? String).flatMap { $0 == "1" }
    }

    @ReferenceGroup public var configurations: [String]?

    func resolveReferences(using objects: [String: PBXObject]) {
        self._configurations.resolveReferences(using: objects)
    }
}

public extension XCConfigurationList {
    var buildConfigurations: [String: XCBuildConfiguration] {
        guard let configs = self.$configurations else { return [:] }
        var buildConfigurations = [String: XCBuildConfiguration]()
        for case let config as XCBuildConfiguration in configs {
            buildConfigurations[config.name!] = config
        }
        return buildConfigurations
    }
}
