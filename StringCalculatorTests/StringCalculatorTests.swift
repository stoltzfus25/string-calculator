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
        XCTAssertEqual(sut.add(""), 0)
    }
    
    func test_oneNumberString_returnsNumber() {
        XCTAssertEqual(sut.add("3"), 3)
    }
    
    func test_twoNumbersString_returnsSum() {
        XCTAssertEqual(sut.add("2,6"), 8)
    }
    
    func test_twoNumbersSeparatedByNewLineAndComma_returnsSum() {
        XCTAssertEqual(sut.add("2\n3,6"), 11)
    }
    
    func test_multipleNumbersSeparatedBySpecifiedDelimiter_returnsSum() {
        XCTAssertEqual(sut.add("//;\n1;2"), 3)
        XCTAssertEqual(sut.add("//'\n3'5"), 8)
    }
}
