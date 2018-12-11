//
//  MovieData.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

// 한 영화의 데이터
import UIKit

struct MovieData: Codable {
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let grade: Int
    let image: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case audience, actor, duration, director, synopsis, genre, grade, image, title, date, id
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }

    func getGradeImage() -> UIImage {
        switch grade {
        case 0:
            return #imageLiteral(resourceName: "ic_allages")
        case 12:
            return #imageLiteral(resourceName: "ic_12")
        case 15:
            return #imageLiteral(resourceName: "ic_15")
        case 19:
            return #imageLiteral(resourceName: "ic_19")
        default:
            return UIImage()
        }
    }
}
