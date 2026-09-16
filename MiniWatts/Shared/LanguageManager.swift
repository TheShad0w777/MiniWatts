import SwiftUI

// MARK: - Language Manager
class LanguageManager: ObservableObject {
    @Published var currentLanguage: String = "az" {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "appLanguage")
            // Force SwiftUI to refresh when language changes
            NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
        }
    }
    
    static let shared = LanguageManager()
    
    private init() {
        // Load saved language preference, default to Azerbaijani
        if let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage") {
            self.currentLanguage = savedLanguage
        } else {
            self.currentLanguage = "az"
        }
    }
    
    var availableLanguages: [(code: String, name: String)] {
        [
            ("az", "Azərbaycanca"),
            ("en", "English")
        ]
    }
    
    func getLanguageName(_ code: String) -> String {
        availableLanguages.first(where: { $0.code == code })?.name ?? code
    }
}
