import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.MusicDomain.rawValue,
    targets: [
        .interface(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .PlayerDomain, type: .interface)
        ]),
        .implements(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain, type: .interface)
        ]),
        .testing(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain, type: .interface)
        ]),
        .tests(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain)
        ])
    ]
)
