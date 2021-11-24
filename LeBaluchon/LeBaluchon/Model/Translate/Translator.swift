//
//  Translator.swift
//  LeBaluchon
//
//  Created by David Da Silva on 28/10/2021.
//



struct Translate: Codable {
    let data: Translations
    struct Translations: Codable {
        var translations: [TranslatedText]
        // swiftlint:disable nesting
        struct TranslatedText: Codable {
            var translatedText: String
        }
    }
}

struct Languages {
    // MARK: - Properties
    static var sourceLanguageCodeISO = "fr"
    static var targetLanguageCodeISO = "en"
}
