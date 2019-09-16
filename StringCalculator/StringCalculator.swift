//
//  StringCalculator.swift
//  StringCalculator
//
//  Created by Samuel Stoltzfus on 9/10/19.
//  Copyright © 2019 Superior Plastic Products, Inc. All rights reserved.
//

import Foundation

class StringCalculator {
    private var callCount: Int = 0
    
    weak var delegate: StringCalculatorDelegate?
    
    func add(_ numberString: String) throws -> Int {
        callCount += 1
        let result = numberStringDelimeterPair(numberString)
        return try add(numberString: result.numberString, delimiter: result.delimiter)
    }
    
    func getCalledCount() -> Int {
        return callCount
    }
    
    private func numberStringDelimeterPair(_ numberString: String) -> (numberString: String, delimiter: String?) {
        guard numberString.starts(with: "//"),
            let splitIndex = numberString.range(of: "\n") else {
            return (numberString, nil)
        }
        
        let delimiterString = String(numberString[..<splitIndex.lowerBound])
        let delimiter = getDelimiter(delimiterString)
        let numberString = String(numberString[splitIndex.upperBound...])
        
        return (numberString, delimiter)
    }
    
    private func getDelimiter(_ delimiterString: String) -> String? {
        let beginOffset = delimiterString.contains("[") ? 3 : 2
        let endOffset = delimiterString.contains("[") ? -2 : -1
        let beginIndex = delimiterString.index(delimiterString.startIndex, offsetBy: beginOffset)
        let endIndex = delimiterString.index(delimiterString.endIndex, offsetBy: endOffset)
        
        let delimiter = String(delimiterString[beginIndex...endIndex])
        return delimiter.isEmpty ? nil : delimiter
    }
    
    private func add(numberString: String, delimiter: String? = nil) throws -> Int {
        delegate?.addOccurred()
        
        var numberStrings = numberString.components(separatedBy: [",","\n"])
        if let delimiter = delimiter {
            numberStrings = numberString.components(separatedBy: delimiter)
        }
        
        let numbers = numberStrings.compactMap { Int($0) }.filter { $0 <= 1000 }
        let negativeNumbers = numbers.filter { abs($0) != $0}
        guard negativeNumbers.isEmpty else {
            throw StringCalculatorError.negativeNumber(numbers: negativeNumbers)
        }
        return numbers.reduce(0, +)
    }
}

enum StringCalculatorError: Error {
    case negativeNumber(numbers: [Int])
}

protocol StringCalculatorDelegate: class {
    func addOccurred()
}
