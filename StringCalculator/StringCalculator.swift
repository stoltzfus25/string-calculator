//
//  StringCalculator.swift
//  StringCalculator
//
//  Created by Samuel Stoltzfus on 9/10/19.
//  Copyright © 2019 Superior Plastic Products, Inc. All rights reserved.
//

import Foundation

public class StringCalculator {
    private var addCallCount: Int = 0
    
    public weak var delegate: StringCalculatorDelegate?
    
    public init() { }
    
    public func add(_ numbers: String) throws -> Int {
        let defaultDelimiters = [",", "\n"]
        let delimiters = defaultDelimiters + getCustomDelimiters(from: numbers)
        
        let numbersInt = split(textArray: [numbers], on: delimiters).compactMap { Int($0) }
        
        let negativeNumbers = numbersInt.filter({ $0 < 0 })
        if !negativeNumbers.isEmpty {
            throw StringCalculatorError.negativeNotAllowed(negativeNumbers)
        }
        
        let result = numbersInt.filter { $0 <= 1000 }.reduce(0, { $0 + $1 })
        
        addCallCount += 1
        delegate?.addOccurred(input: numbers, result: result)
        
        return result
    }
    
    public func getCallCount() -> Int {
        addCallCount
    }
    
    private func getCustomDelimiters(from text: String) -> [String] {
        guard text.starts(with: "//"),
              let delimiterSection = split(textArray: [text], on: ["\n"]).first
        else {
            return []
        }
        
        let delimiterSectionSanitized = delimiterSection.dropFirst(2).trimmingCharacters(in: ["[", "]"])
        return split(textArray: [delimiterSectionSanitized], on: ["]["])
    }
    
    private func split(textArray: [String], on delimiters: [String]) -> [String] {
        guard let delimiter = delimiters.first else {
            return textArray
        }
        
        let newDelimiters = Array(delimiters.dropFirst())
        let newTextArray = textArray.flatMap { $0.components(separatedBy: delimiter) }
        return split(textArray: newTextArray, on: newDelimiters)
    }
}

public enum StringCalculatorError: Error, Equatable {
    case negativeNotAllowed(_ numbers: [Int])
}

public protocol StringCalculatorDelegate: class {
    func addOccurred(input: String, result: Int)
}
