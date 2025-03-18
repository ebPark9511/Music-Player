//
//  AlbumDetailRootViewable.swift
//  AlbumDetailFeature
//
//  Created by 박은비 on 3/17/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import SwiftUI

public struct AlbumDetailBuilder: View {
    
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
