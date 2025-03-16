import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.AlbumsFeature.rawValue,
    targets: [
        .interface(module: .feature(.AlbumsFeature)),
        .implements(module: .feature(.AlbumsFeature), dependencies: [
            .feature(target: .AlbumsFeature, type: .interface),
            .feature(target: .BaseFeature),
            .domain(target: .MusicDomain, type: .interface)
        ]),
        .testing(module: .feature(.AlbumsFeature), dependencies: [
            .feature(target: .AlbumsFeature, type: .interface)
        ]),
        .tests(module: .feature(.AlbumsFeature), dependencies: [
            .feature(target: .AlbumsFeature)
        ]),
        .demo(module: .feature(.AlbumsFeature), dependencies: [
            .feature(target: .AlbumsFeature)
        ])
    ]
)
