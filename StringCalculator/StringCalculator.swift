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
        return Int(numberString) ?? 0
    }
}
