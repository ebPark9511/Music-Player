import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.PlayerFeature.rawValue,
    targets: [
        .interface(module: .feature(.PlayerFeature)),
        .implements(module: .feature(.PlayerFeature), dependencies: [
            .feature(target: .PlayerFeature, type: .interface),
            .domain(target: .PlayerDomain, type: .interface),
            .domain(target: .MusicDomain, type: .interface),
            .feature(target: .BaseFeature),
        ])
    ]
)
