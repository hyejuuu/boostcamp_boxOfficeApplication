//
//  BinaryInteger.swift
//  boxOffice
//
//  Created by 이혜주 on 11/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import Foundation

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
