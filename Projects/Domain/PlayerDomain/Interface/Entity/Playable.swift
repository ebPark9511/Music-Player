//
//  Playable.swift
//  PlayerDomain
//
//  Created by 박은비 on 3/15/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import UIKit

public protocol Playable {
    var id: String { get }
    var title: String? { get }
    var artist: String? { get }
    var artworkImage: UIImage? { get }
    var duration: TimeInterval { get }
}
