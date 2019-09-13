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
        XCTAssertEqual(try sut.add(""), 0)
    }
    
    func test_oneNumberString_returnsNumber() {
        XCTAssertEqual(try sut.add("3"), 3)
    }
    
    func test_twoNumbersString_returnsSum() {
        XCTAssertEqual(try sut.add("2,6"), 8)
    }
    
    func test_twoNumbersSeparatedByNewLineAndComma_returnsSum() {
        XCTAssertEqual(try sut.add("2\n3,6"), 11)
    }
    
    func test_multipleNumbersSeparatedBySpecifiedDelimiter_returnsSum() {
        XCTAssertEqual(try sut.add("//;\n1;2"), 3)
        XCTAssertEqual(try sut.add("//'\n3'5"), 8)
    }
    
    func test_negativeNumber_throwsNegativeNumberExceptionWithNegativeNumber() {
        XCTAssertThrowsError(try sut.add("-6"), "must throw error") { error in
            guard case StringCalculatorError.negativeNumber(let number) = error else {
                return XCTFail()
            }
            XCTAssertEqual(number, [-6])
        }
        
        XCTAssertThrowsError(try sut.add("2\n-3,6"), "must throw error") { error in
            guard case StringCalculatorError.negativeNumber(let number) = error else {
                return XCTFail()
            }
            XCTAssertEqual(number, [-3])
        }
        
        XCTAssertThrowsError(try sut.add("//;\n-1;-2"), "must throw error") { error in
            guard case StringCalculatorError.negativeNumber(let number) = error else {
                return XCTFail()
            }
            XCTAssertEqual(number, [-1, -2])
        }
    }
    
    func test_getCalledCount_returnsCorrectCount() {
        let _ = try! sut.add("9")
        XCTAssertEqual(sut.getCalledCount(), 1)
        
        let _ = try! sut.add("9")
        let _ = try! sut.add("9")
        let _ = try! sut.add("9")
        XCTAssertEqual(sut.getCalledCount(), 4)
    }
}
