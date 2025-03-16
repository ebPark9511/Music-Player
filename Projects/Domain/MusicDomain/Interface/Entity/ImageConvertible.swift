//
//  ImageConvertible.swift
//  MusicDomain
//
//  Created by 박은비 on 3/16/25.
//  Copyright © 2025 ebpark. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageConvertible {
    func image(at size: CGSize) -> UIImage?
}
