//
//  TextFieldStyle.swift
//  NetworkLayer
//
//  Created by Mohammed Hamdi on 02/10/2022.
//

import Foundation
import SwiftUI

enum TextFieldStyle {
    case `default`(borderColor:Color = .blue, placeholderAlignment : HorizontalAlignment = .leading)
    case custom(config: TextFieldStyleConfig)
}

extension TextFieldStyle {
    var styleConfig: TextFieldStyleConfig {
        switch self {
        case .default(borderColor: let borderColor, placeholderAlignment: let placeholderAlignment):
            
            return TextFieldStyleConfig(
                placeholderAlignment: placeholderAlignment,
                cornerStyle: .ellipse,
                borderColor: borderColor,
                borderWidth: 1
            )
            
        case .custom(config: let config):
            return config
        }
    }
}
