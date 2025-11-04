//
//  ToastPosition.swift
//  ProCare
//
//  Created by ahmed hussien on 14/05/2025.
//

import Foundation
import SwiftUICore

enum AppToastPosition {
    case top, center, bottom
}

struct AppToast: Equatable {
    var style: AppToastStyle
    var message: String
    var duration: Double = 3
    var width: CGFloat = .infinity
    var position: AppToastPosition = .top // default position
}
