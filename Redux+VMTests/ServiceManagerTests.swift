//
//  ServiceManagerTests.swift
//  Redux+VMTests
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import XCTest

class ServiceManagerTests: XCTestCase {
    let serviceManager = MockServiceManager()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNews() {
        let exp = expectation(description: "News Parsing")
        serviceManager.fetchArticle { (news, error) in
            // Error Should be nil
            XCTAssertNil(error)
            //
            guard let response = news else{
                XCTFail()
                return
            }
            XCTAssertNotNil(response)
            XCTAssert(response.articles?.count == 10)
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

}
