import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.MusicDomain.rawValue,
    targets: [
        .interface(module: .domain(.MusicDomain), dependencies: []),
        .implements(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain, type: .interface),
            .domain(target: .BaseDomain),
            .core(target: .MediaKit, type: .interface)
        ]),
        .testing(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain, type: .interface)
        ]),
        .tests(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain)
        ])
    ]
)
