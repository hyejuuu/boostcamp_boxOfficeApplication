//
//  MovieTableViewCell.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie, let url = URL(string: movie.thumb) else {
                return
            }
            
            if let image = cache.object(forKey: url.absoluteString as NSString) {
                movieImageView.image = image
            } else {
                getImage(url: url, completion: { (image, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.movieImageView.image = cache.object(forKey: url.absoluteString as NSString)
                    }
                })
            }
            
            movieNameLabel.text = movie.title
            ratingLabel.text = "평점 : \(movie.userRating) 예매순위 : \(movie.reservationGrade) 예매율 : \(movie.reservationRate)"
            releaseLabel.text = "개봉일 : \(movie.date)"
            
            gradeImageView.image = movie.getGradeImage()
        }
    }
    
}
