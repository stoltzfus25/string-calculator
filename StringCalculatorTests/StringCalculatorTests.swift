//
//  StringCalculatorTests.swift
//  StringCalculatorTests
//
//  Created by Samuel Stoltzfus on 9/10/19.
//  Copyright © 2019 Superior Plastic Products, Inc. All rights reserved.
//

import XCTest
import StringCalculator

class StringCalculatorTests: XCTestCase {
    var sut: StringCalculator!
    
    override func setUp() {
        sut = StringCalculator()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_emptyString_returnsZero() {
        XCTAssertEqual(0, try sut.add(""))
    }
    
    func test_oneNumber_returnsNumber() {
        XCTAssertEqual(0, try sut.add("0"))
        XCTAssertEqual(5, try sut.add("5"))
        XCTAssertEqual(99, try sut.add("99"))
    }
    
    func test_multipleNumbers_returnsSum() {
        XCTAssertEqual(3, try sut.add("1,2"))
        XCTAssertEqual(55, try sut.add("1,2,3,4,5,6,7,8,9,10"))
        XCTAssertEqual(111, try sut.add("1,10,100"))
    }
    
    func test_multipleNumbersCommaOrNewLineSeparated_returnsSum() {
        XCTAssertEqual(6, try sut.add("1\n2,3"))
        XCTAssertEqual(6, try sut.add("1\n2\n3"))
    }
    
    func test_multipleNumbersWithCustomDelimiter_returnsSum() {
        XCTAssertEqual(3, try sut.add("//;\n1;2"))
        XCTAssertEqual(16, try sut.add("//--\n10--6"))
    }
    
    func test_negativeNumbers_throwsErrorWithNegativeNumbers() {
        XCTAssertThrowsError(try sut.add("-1")) { error in
            XCTAssertEqual(StringCalculatorError.negativeNotAllowed([-1]), error as? StringCalculatorError)
        }
        
        XCTAssertThrowsError(try sut.add("//--\n-10---6")) { error in
            XCTAssertEqual(StringCalculatorError.negativeNotAllowed([-10, -6]), error as? StringCalculatorError)
        }
    }
    
    func test_adding_incrementsCallCount() throws {
        _ = try sut.add("")
        _ = try sut.add("")
        
        XCTAssertEqual(2, sut.getCallCount())
    }
    
    func test_adding_callsDelegate() throws {
        let delegate = StringCalculatorDelegateSpy()
        sut.delegate = delegate
        
        XCTAssertEqual([], delegate.inputs)
        XCTAssertEqual([], delegate.results)
        
        let input1 = "1"
        let result1 = try sut.add(input1)
        
        let input2 = "3\n6"
        let result2 = try sut.add(input2)
        
        let input3 = "//*5*6*11"
        let result3 = try sut.add(input3)
        
        XCTAssertEqual([input1, input2, input3], delegate.inputs)
        XCTAssertEqual([result1, result2, result3], delegate.results)
    }
    
    func test_memoryLeakForDelegate() throws {
        var delegate = StringCalculatorDelegateSpy()
        sut.delegate = delegate
        
        delegate = StringCalculatorDelegateSpy()
        
        XCTAssertNil(sut.delegate, "should be deallocated")
    }
    
    func test_numbersBiggerThan1000_getIgnored() {
        XCTAssertEqual(2, try sut.add("2,1001"))
        XCTAssertEqual(1000, try sut.add("1000\n10000\n100000"))
    }
    
    func test_delimitersCanBeAnyLength() {
        XCTAssertEqual(6, try sut.add("//[***]\n1***2***3"))
        XCTAssertEqual(6, try sut.add("//[/$?]\n1/$?2/$?3"))
    }
    
    func test_allowMultipleDelimiters() {
        XCTAssertEqual(6, try sut.add("//[*][%]\n1*2%3"))
        XCTAssertEqual(21, try sut.add("//[*][-][%]\n1-2%3*4\n5,6"))
        XCTAssertEqual(21, try sut.add("//[**][-][%%%]\n1-2%%%3**4\n5,6"))
    }
}

private class StringCalculatorDelegateSpy: StringCalculatorDelegate {
    var inputs = [String]()
    var results = [Int]()
    
    func addOccurred(input: String, result: Int) {
        inputs.append(input)
        results.append(result)
    }
}
