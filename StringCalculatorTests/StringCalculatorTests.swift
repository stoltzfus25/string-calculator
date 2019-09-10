//
//  StringCalculatorTests.swift
//  StringCalculatorTests
//
//  Created by Samuel Stoltzfus on 9/10/19.
//  Copyright © 2019 Superior Plastic Products, Inc. All rights reserved.
//

import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {

    var sut: StringCalculator!
    
    override func setUp() {
        sut = StringCalculator()
    }

    override func tearDown() {
        sut = nil
    }
    
    func test_emptyString_returnsZero() {
        let result = sut.add("")
        XCTAssertEqual(result, 0)
    }
    
    func test_oneNumberString_returnsNumber() {
        let result = sut.add("3")
        XCTAssertEqual(result, 3)
    }
}
