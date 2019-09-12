//
//  StringCalculator.swift
//  StringCalculator
//
//  Created by Samuel Stoltzfus on 9/10/19.
//  Copyright © 2019 Superior Plastic Products, Inc. All rights reserved.
//

import Foundation

class StringCalculator {
    func add(_ numberString: String) -> Int {
        let result = numberStringDelimeterPair(numberString)
        return add(numberString: result.numberString, delimiter: result.delimiter)
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
        let delimiter = String(delimiterString.dropFirst(2))
        return delimiter.isEmpty ? nil : delimiter
    }
    
    private func add(numberString: String, delimiter: String? = nil) -> Int {
        var numberStrings = numberString.components(separatedBy: [",","\n"])
        if let delimiter = delimiter {
            numberStrings = numberString.components(separatedBy: delimiter)
        }
        
        let numbers = numberStrings.compactMap { Int($0) }
        return numbers.reduce(0, +)
    }
}
