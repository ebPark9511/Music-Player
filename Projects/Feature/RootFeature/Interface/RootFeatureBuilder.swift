//
//  RootFeatureBuilder.swift
//  RootFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI

public struct RootFeatureBuilder: View {
    
    private let viewBuilder: () -> any View
    
    public init(
        @ViewBuilder viewBuilder: @escaping () -> some View
    ) {
        self.viewBuilder = viewBuilder
    }
 
    public var body: some View {
        AnyView(viewBuilder())
    }
}

