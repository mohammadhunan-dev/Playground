//
//  FunctionsPlaygroundTests.swift
//  FunctionsPlaygroundTests
//
//  Created by Dominic Frei on 13/01/2021.
//

import XCTest
@testable import FunctionsPlayground
import RealmSwift

class FunctionsPlaygroundTests: XCTestCase {
    
    func testExample_Fail() throws {
        let expectation = XCTestExpectation(description: "")
        App(id: "functions-gjsvg").login(credentials: Credentials.anonymous) { (loginResult) in
            switch loginResult {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let user):
                XCTAssertNotNil(user)
                XCTAssertNotNil(App(id: "functions-gjsvg").currentUser)
                App(id: "functions-gjsvg").currentUser!.functions.function0([1, 2]) { sum, error in
                    guard error == nil else {
                        XCTFail(String(describing: error))
                        return
                    }
                    guard case let .double(value) = sum else {
                        XCTFail("Unexpected non-double result: \(sum ?? "nil")");
                        return
                    }
                    XCTAssertEqual(value, 3)
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testExample_Success() throws {
        let expectation = XCTestExpectation(description: "")
        App(id: "functions-gjsvg").login(credentials: Credentials.anonymous) { (loginResult) in
            switch loginResult {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let user):
                XCTAssertNotNil(user)
                XCTAssertNotNil(App(id: "functions-gjsvg").currentUser)
                user.functions.function0([1, 2]) { sum, error in
                    guard error == nil else {
                        XCTFail(String(describing: error))
                        return
                    }
                    guard case let .double(value) = sum else {
                        XCTFail("Unexpected non-double result: \(sum ?? "nil")");
                        return
                    }
                    XCTAssertEqual(value, 3)
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
    }

}
