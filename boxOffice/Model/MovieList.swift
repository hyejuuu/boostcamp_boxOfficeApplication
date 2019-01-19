//
//  MovieList.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

// 모든 영화 리스트
import UIKit

struct MovieList: Codable {
    let orderType: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case orderType = "order_type"
        case movies
    }
}

struct Movie: Codable, GradeHaving {
    let grade: Grade
    let thumb: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case grade, thumb, title, date, id
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
}
