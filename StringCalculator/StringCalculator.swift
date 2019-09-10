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
        let numbers = numberString.components(separatedBy: ",").compactMap { Int($0) }
        return numbers.reduce(0, +)
    }
}
