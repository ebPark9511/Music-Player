import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.AlbumDetailFeature.rawValue,
    targets: [
        .interface(module: .feature(.AlbumDetailFeature)),
        .implements(module: .feature(.AlbumDetailFeature), dependencies: [
            .feature(target: .AlbumDetailFeature, type: .interface),
            .feature(target: .BaseFeature),
            .domain(target: .MusicDomain, type: .interface),
            .domain(target: .PlayerDomain, type: .interface),
        ]),
        .testing(module: .feature(.AlbumDetailFeature), dependencies: [
            .feature(target: .AlbumDetailFeature, type: .interface)
        ]),
        .tests(module: .feature(.AlbumDetailFeature), dependencies: [
            .feature(target: .AlbumDetailFeature)
        ]),
        .demo(module: .feature(.AlbumDetailFeature), dependencies: [
            .feature(target: .AlbumDetailFeature)
        ])
    ]
)
