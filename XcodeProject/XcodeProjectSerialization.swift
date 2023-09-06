import Foundation

public enum XcodeProjectSerialization {
    public static func project(from project: [String: Any]) -> (PBXProject, [String: PBXObject])? {
        guard let root = (project["rootObject"] as? String),
              let objects = (project["objects"] as? [String: [String: Any]]) else {
            return nil
        }
        var objectGraph = [String: PBXObject]()
        for (id, rawValue) in objects {
            objectGraph[id] = PBXObject.from(id, rawValue)
        }
        for case let referencingObject as Referencing in objectGraph.values {
            referencingObject.resolveReferences(using: objectGraph)
        }
        return ((objectGraph[root]! as! PBXProject), objectGraph)
    }

    public static func project(from data: Data) -> (PBXProject, [String: PBXObject])? {
        guard let raw = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return nil
        }
        return self.project(from: raw)
    }

    public static func project(from fileURL: URL) -> (PBXProject, [String: PBXObject])? {
        guard fileURL.isFileURL else { return nil }
        if fileURL.pathExtension == "pbxproj" {
            return try? self.project(from: Data(contentsOf: fileURL, options: .mappedIfSafe))
        }
        if fileURL.pathExtension == "xcodeproj" {
            return self.project(from: fileURL.appendingPathComponent("project.pbxproj"))
        }
        return nil
    }
}
