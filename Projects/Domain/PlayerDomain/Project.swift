import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.PlayerDomain.rawValue,
    targets: [
        .interface(module: .domain(.PlayerDomain)),
        .implements(module: .domain(.PlayerDomain), dependencies: [
            .domain(target: .PlayerDomain, type: .interface)
        ]),
        .testing(module: .domain(.PlayerDomain), dependencies: [
            .domain(target: .PlayerDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .tests(module: .domain(.PlayerDomain), dependencies: [
            .domain(target: .PlayerDomain)
        ])
    ]
)
