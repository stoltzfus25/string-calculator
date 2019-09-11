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
        if numberString.starts(with: "//") {
            // custom delimiter
            let newNumberString = numberString.components(separatedBy: "\n")[1...].reduce("", +)
            let delimiter = numberString.components(separatedBy: "\n")[0].dropFirst(2)
            
            let numberStrings = "\(newNumberString)".components(separatedBy: delimiter)
            let numbers = numberStrings.compactMap { Int($0) }
            return numbers.reduce(0, +)
        } else {
            let numberStrings = numberString.components(separatedBy: [",","\n"])
            let numbers = numberStrings.compactMap { Int($0) }
            return numbers.reduce(0, +)
        }
    }
}
