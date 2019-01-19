//
//  GradeHaving.swift
//  boxOffice
//
//  Created by 장공의 on 20/01/2019.
//  Copyright © 2019 leehyeju. All rights reserved.
//

import Foundation
import UIKit

enum Grade: Int, Codable {
    case all = 0
    case twelve = 12
    case fifteen = 15
    case adult = 19
}

protocol GradeHaving {
    var grade: Grade { get }
}

extension GradeHaving {
    func getGradeImage() -> UIImage {
        switch grade {
        case .all:
            return #imageLiteral(resourceName: "ic_allages")
        case .twelve:
            return #imageLiteral(resourceName: "ic_12")
        case .fifteen:
            return #imageLiteral(resourceName: "ic_15")
        case .adult:
            return #imageLiteral(resourceName: "ic_19")
        }
    }
}
