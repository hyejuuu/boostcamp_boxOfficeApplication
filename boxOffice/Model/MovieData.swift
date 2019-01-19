//
//  MovieData.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

// 영화의 데이터
import UIKit

struct MovieData: Codable, Graded {
    let grade: Grade
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
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
}
