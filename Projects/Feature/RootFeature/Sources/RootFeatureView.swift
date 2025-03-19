//
//  RootFeatureView.swift
//  RootFeatureInterface
//
//  Created by 박은비 on 3/19/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import SwiftUI

struct RootFeatureView: View {
    
    private let viewBuilder: () -> any View
    private let playerViewBuilder: () -> any View
    
    init(
        @ViewBuilder viewBuilder: @escaping () -> some View,
        @ViewBuilder playerViewBuilder: @escaping () -> some View
    ) {
        self.viewBuilder = viewBuilder
        self.playerViewBuilder = playerViewBuilder
    }
    
    var body: some View {
        ZStack {
            AnyView(viewBuilder())
            
            VStack {
                Spacer()
                AnyView(playerViewBuilder())
            }
        }
    }
}
