//
//  WeatherAppSnapKitTests.swift
//  WeatherAppSnapKitTests
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import XCTest

@testable import WeatherAppSnapKit

class WeatherAppSnapKitTests: XCTestCase {
    var session: URLSession!
    override func setUpWithError() throws {
        session = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

   /* func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
extension WeatherAppSnapKitTests {
    func testCoreDataArrayLoaded() {
        let viewModel = HomeVM()
        XCTAssertEqual(viewModel.coreDataArray.count, 0, "coreDataArray must be 0")
    }
    func testStatusCode200() {
        // given
        let url =
            URL(string: "https://api.openweathermap.org/data/2.5/weather?lon=28.860573472383756&lat=41.00210304899445&appid=bfbc5a83368b83d9af3a739264606829")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = session.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
}
