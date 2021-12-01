//
//  ExchangeRateServiceTest.swift
//  LeBaluchonTests
//
//  Created by David Da Silva on 30/11/2021.
//

@testable import LeBaluchon
import XCTest

class ExchangeRateServiceTestCase: XCTestCase {
    
//    Si un erreur a été reçu
    func testGetExchangeRateShouldPostFailedCallbackIfError() {
        // Given
        let exchangeRateService = ExchangeRateService(exchangeRateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { success, exchangeRate in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    //    Si aucune donné a été reçu
    func testGetExchangeRateShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeRateService = ExchangeRateService(exchangeRateSession: URLSessionFake(data: nil, response: nil, error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { success, exchangeRate in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

//    Si j'ai des donné, pas d'erreur mais reponse incorrect
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeRateService = ExchangeRateService(exchangeRateSession: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseKO, error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { success, exchangeRate in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    //    Si j'ai des donné mais incoorect et  reponse correct
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectData() {
          // Given
          let exchangeRateService = ExchangeRateService(exchangeRateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)
          )

          // When
          let expectation = XCTestExpectation(description: "Wait for queue change.")
          exchangeRateService.getExchangeRate { success, exchangeRate in
              //Then
              XCTAssertFalse(success)
              XCTAssertNil(exchangeRate)
              expectation.fulfill()
          }

          wait(for: [expectation], timeout: 0.01)
      }
    
    //    Si j'ai des donné correct,reponse correct et pas d'erreur 
    func testGetExchangeRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let exchangeRateService = ExchangeRateService(exchangeRateSession: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { success, exchangeRate in
            //Then
            let usdRate: Decimal = 1.185319

            XCTAssertTrue(success)
            XCTAssertNotNil(exchangeRate)
            XCTAssertEqual(usdRate, exchangeRate?.rates.usd)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}
