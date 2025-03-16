import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.MediaKit.rawValue,
    targets: [
        .interface(module: .core(.MediaKit)),
        .implements(module: .core(.MediaKit), dependencies: [
            .core(target: .MediaKit, type: .interface),
            .domain(target: .BaseDomain)
        ])
    ]
)
