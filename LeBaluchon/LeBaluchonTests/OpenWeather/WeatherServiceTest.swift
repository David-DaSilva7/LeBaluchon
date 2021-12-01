//
//  WeatherServiceTest.swift
//  LeBaluchonTests
//
//  Created by David Da Silva on 30/11/2021.
//

@testable import LeBaluchon
import XCTest

class WeatherServiceTest: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil,
                                                                           response: nil,
                                                                           error: FakeResponseData.error)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(entireWeather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil,
                                                                           response: nil,
                                                                           error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(entireWeather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseKO,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(entireWeather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
          // Given
          let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
          )

          // When
          let expectation = XCTestExpectation(description: "Wait for queue change.")
          weatherService.getWeather(for: .newYork) { success, entireWeather in
              //Then
              XCTAssertFalse(success)
              XCTAssertNil(entireWeather)
              expectation.fulfill()
          }

          wait(for: [expectation], timeout: 0.01)
      }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            let description = "clear sky"
            let temp = 282.55
            let feels_like = 281.86

            XCTAssertTrue(success)
            XCTAssertNotNil(entireWeather)
            XCTAssertEqual(feels_like, entireWeather?.main.feels_like)
            XCTAssertEqual(description, entireWeather?.weather[0].description)
            XCTAssertEqual(temp, entireWeather?.main.temp)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}

