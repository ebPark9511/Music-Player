import Foundation
import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let organizationName: String
    public let destinations: Destinations
    public let deploymentTargets: DeploymentTargets
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    name: "Music-Player",
    organizationName: "ebpark",
    destinations: [.iPhone, .iPad],
    deploymentTargets: .iOS("18.0"),
    baseSetting: [:]
)
