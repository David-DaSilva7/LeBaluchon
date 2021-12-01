//
//  TranslateServiceTest.swift
//  LeBaluchonTests
//
//  Created by David Da Silva on 30/11/2021.
//

import XCTest
@testable import LeBaluchon

class TranslateServiceTest: XCTestCase {

    
//    Si un erreur a été reçu
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslatorService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    //    Si aucune donné a été reçu
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslatorService(translateSession: URLSessionFake(data: nil,
                                                                                 response: nil,
                                                                                 error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

//    Si j'ai des donné, pas d'erreur mais reponse incorrect
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslatorService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseKO,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    //    Si j'ai des donné mais incoorect et  reponse correct
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslatorService(translateSession: URLSessionFake(
          data: FakeResponseData.incorrectData,
          response: FakeResponseData.responseOK,
          error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
      }
    
    //    Si j'ai des donné correct,reponse correct et pas d'erreur
    func testGetTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslatorService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            let text = "Hello how are you?"

            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            XCTAssertEqual(text, translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
