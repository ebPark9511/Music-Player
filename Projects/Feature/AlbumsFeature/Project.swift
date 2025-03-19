import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.AlbumsFeature.rawValue,
    targets: [
        .interface(module: .feature(.AlbumsFeature)),
        .implements(module: .feature(.AlbumsFeature), dependencies: [
            .feature(target: .AlbumsFeature, type: .interface),
            .domain(target: .MusicDomain, type: .interface),
            .feature(target: .BaseFeature),
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
