import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let configurations: [Configuration] = .default

let settings: Settings = .settings(
    base: env.baseSetting,
    configurations: configurations,
    defaultSettings: .recommended
)

let scripts: [TargetScript] = generateEnvironment.scripts

let targets: [Target] = [
    .target(
        name: env.name,
        destinations: env.destinations,
        product: .app,
        bundleId: "\(env.organizationName).\(env.name)",
        deploymentTargets: env.deploymentTargets,
        infoPlist: .file(path: "Support/Info.plist"),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        scripts: scripts,
        dependencies:
            ModulePaths.Feature.allCases.map { TargetDependency.feature(target: $0) }
            + ModulePaths.Domain.allCases.map { TargetDependency.domain(target: $0) }
        ,
        settings: .settings(base: env.baseSetting)
    )
]

let schemes: [Scheme] = [
    .scheme(
        name: "\(env.name)-DEV",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .dev),
        archiveAction: .archiveAction(configuration: .dev),
        profileAction: .profileAction(configuration: .dev),
        analyzeAction: .analyzeAction(configuration: .dev)
    )
]

let project = Project(
    name: env.name,
    organizationName: env.organizationName,
    settings: settings,
    targets: targets,
    schemes: schemes
)
