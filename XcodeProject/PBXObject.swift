import Foundation

open class PBXObject {
    public let id: String
    public let rawValue: [String: Any]

    public required init?(_ id: String, _ rawValue: [String: Any]) {
        self.id = id
        self.rawValue = rawValue
    }
}

extension PBXObject {
    static let KNOWN_ISA = [
        "PBXFileReference": PBXFileReference.self,
        "PBXGroup": PBXGroup.self,
        "PBXBuildFile": PBXBuildFile.self,
        "XCBuildConfiguration": XCBuildConfiguration.self,
        "PBXNativeTarget": PBXNativeTarget.self,
        "XCConfigurationList": XCConfigurationList.self,
        "PBXFrameworksBuildPhase": PBXFrameworksBuildPhase.self,
        "PBXHeadersBuildPhase": PBXHeadersBuildPhase.self,
        "PBXResourcesBuildPhase": PBXResourcesBuildPhase.self,
        "PBXSourcesBuildPhase": PBXSourcesBuildPhase.self,
        "PBXTargetDependency": PBXTargetDependency.self,
        "PBXContainerItemProxy": PBXContainerItemProxy.self,
        "PBXCopyFilesBuildPhase": PBXCopyFilesBuildPhase.self,
        "PBXProject": PBXProject.self,
        "PBXShellScriptBuildPhase": PBXShellScriptBuildPhase.self,
        "PBXVariantGroup": PBXVariantGroup.self,
        "XCVersionGroup": XCVersionGroup.self,
    ]

    public static func from(_ id: String, _ rawValue: [String: Any]) -> PBXObject {
        if let type = (rawValue["isa"] as? String).flatMap({ PBXObject.KNOWN_ISA[$0] }),
           let instance = type.init(id, rawValue) {
            return instance
        }
        assertionFailure("FIXME: \(id) \((rawValue["isa"] as? String) ?? String())")
        return PBXObject(id, rawValue)!
    }
}
