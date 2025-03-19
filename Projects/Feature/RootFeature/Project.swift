import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.RootFeature.rawValue,
    targets: [
        .interface(module: .feature(.RootFeature)),
        .implements(module: .feature(.RootFeature), dependencies: [
            .feature(target: .RootFeature, type: .interface),
            .feature(target: .AlbumsFeature, type: .interface),
            .feature(target: .PlayerFeature, type: .interface),
            .feature(target: .BaseFeature)
        ])
    ]
)
