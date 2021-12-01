//
//  Translator.swift
//  LeBaluchon
//
//  Created by David Da Silva on 28/10/2021.
//


// MARK: - Translate
struct Translate: Codable {
    let data: Translations
}
struct Translations: Codable {
    var translations: [TranslatedText]
}

struct TranslatedText: Codable {
    var translatedText: String
}

// MARK: - Languages
struct Languages {
    static var sourceLanguageCodeISO = "fr"
    static var targetLanguageCodeISO = "en"
}
