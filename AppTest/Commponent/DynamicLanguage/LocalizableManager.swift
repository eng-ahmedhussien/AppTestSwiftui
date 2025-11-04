//
//  Untitled.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 17/03/2025.
//

import Foundation
import SwiftUI

class LocalizableManager: ObservableObject {
    static let shared = LocalizableManager()
    
    @AppStorage("currentLanguage")
    private var storedLanguage: LanguageTypes = .english
    
    @Published var currentLanguage: LanguageTypes = .english {
        didSet {
            storedLanguage = currentLanguage
            Bundle.setLanguage(language: currentLanguage.rawValue)
            objectWillChange.send() // Explicitly notify views
        }
    }
    
    func localize(_ key: String) -> String {
        NSLocalizedString(key, bundle: Bundle.localizedBundle(), comment: "")
    }
    
    private init() {
        currentLanguage = storedLanguage
        Bundle.setLanguage(language: storedLanguage.rawValue)
    }
}

//MARK: - Language Types
enum LanguageTypes: String, CaseIterable, RawRepresentable {
    case english = "en"
    case arabic = "ar"

    var name: String {
        switch self {
        case .english: return "English"
        case .arabic: return "عربي"
        }
    }
}

//This extension helps in loading the localized strings.
extension String {
    func localized() -> String {
        return Bundle.localizedBundle().localizedString(forKey: self, value: nil, table: nil)
    }
}

//This code helps the app load the correct language bundle when the user switches languages.
extension Bundle {
    private static var bundle: Bundle!
    
    static func setLanguage(language: String) {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        bundle = path != nil ? Bundle(path: path!) : Bundle.main
    }
    
    static func localizedBundle() -> Bundle {
        return bundle ?? Bundle.main
    }
}
