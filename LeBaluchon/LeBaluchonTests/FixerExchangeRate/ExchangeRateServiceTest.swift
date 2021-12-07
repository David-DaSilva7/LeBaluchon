//
//  ExchangeRateServiceTest.swift
//  LeBaluchonTests
//
//  Created by David Da Silva on 30/11/2021.
//

@testable import LeBaluchon
import XCTest

class ExchangeRateServiceTestCase: XCTestCase {
    
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
