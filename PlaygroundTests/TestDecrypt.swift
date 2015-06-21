//
//  PlaygroundTests.swift
//  PlaygroundTests
//
//  Created by George Yamana on 21/04/2015.
//  Copyright (c) 2015 localz. All rights reserved.
//

import UIKit
import XCTest

class TestDecrypt: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDecryptHexString() {
        let encrypted = "7b52e4a78b94f0d65a7edda603d59482:ffc11fc640a4d5bcb0215fab31ed166d8faf46e4e88d803caf2e78dd331109cb"
        let keyString = "4877853790168452973"
        let expected = "This is my original text"
        let expectedLength = 24
        let result = Decrypt.decryptHexString(encrypted, keyString: keyString)
        // This is an example of a functional test case.
        XCTAssertEqual(expected, result)
        XCTAssertEqual(expectedLength, count(result))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
