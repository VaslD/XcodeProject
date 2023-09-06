import Foundation
import XcodeProject

func printFileTree(_ root: PBXFileObject, indent: Int = 0) {
    if indent == 0 {
        print("FileReferences:")
        printFileTree(root, indent: 2)
        return
    }

    guard let children = (root as? PBXFolderObject)?.files, !children.isEmpty else {
        if indent == 2 {
            print("\(String(repeating: " ", count: indent))- \(root.id)")
        } else {
            print("\(String(repeating: " ", count: indent))- \"\(root.path!)\"")
        }
        return
    }

    if indent == 2 {
        print("\(String(repeating: " ", count: indent))- \(root.id):")
    } else {
        print("\(String(repeating: " ", count: indent))- \"\(root.path!)\":")
    }
    for child in children.sorted(by: { $0.path! < $1.path! }) {
        printFileTree(child, indent: indent + 2)
    }
}

func printTargets(_ project: PBXProject) {
    print("Targets:")
    for target in project.nativeTargets {
        print("  \(target.name!):")

        if let configs = target.buildConfigurations {
            print("    Configurations:")
            for (name, config) in configs.buildConfigurations {
                print("      \(name):")
                if let base = config.baseConfiguration {
                    print("        Base: \"\(base.path!)\"")
                }
                if let settings = config.settings, JSONSerialization.isValidJSONObject(settings) {
                    let serialized = try! String(data: JSONSerialization.data(withJSONObject: settings,
                                                                              options: [.sortedKeys,
                                                                                        .withoutEscapingSlashes]),
                                                 encoding: .utf8)!
                    print("        XCConfig: '\(serialized)'")
                }
            }
        }

        if let phase = target.headersPhase, !phase.fileReferences.isEmpty {
            print("    Headers:")
            for file in phase.fileReferences.sorted(by: { $0.path! < $1.path! }) {
                print("      - \"\(file.path!)\"")
            }
        }
        if let phase = target.compileSourcesPhase, !phase.fileReferences.isEmpty {
            print("    Sources:")
            for file in phase.fileReferences.sorted(by: { $0.path! < $1.path! }) {
                print("      - \"\(file.path!)\"")
            }
        }
        if let phase = target.linkBinaryWithLibrariesPhase, !phase.fileReferences.isEmpty {
            print("    Frameworks:")
            for file in phase.fileReferences.sorted(by: { $0.path! < $1.path! }) {
                print("      - \"\(file.path!)\"")
            }
        }
        if let phase = target.copyBundleResourcesPhase, !phase.fileReferences.isEmpty {
            print("    Resources:")
            for file in phase.fileReferences.sorted(by: { $0.path! < $1.path! }) {
                print("      - \"\(file.path!)\"")
            }
        }
    }
}

// MARK: - @main

let fileURL = URL(fileURLWithPath: "/Users/vasld/Downloads/project.pbxproj")
let (project, objects) = XcodeProjectSerialization.project(from: fileURL)!
print("Project: \"\(fileURL.path)\"")
printFileTree(project.fileRoot!)
printTargets(project)
