//
//  MovieCollectionViewCell.swift
//  boxOffice
//
//  Created by 이혜주 on 07/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

// 영화 목록을 보여줄 collectionView에서 사용될 cell
class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    
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
            ratingLabel.text = "\(movie.reservationGrade)위(\(movie.userRating)) / \(movie.reservationRate)%"
            releaseLabel.text = "\(movie.date)"
            
            gradeImageView.image = movie.getGradeImage()
        }
    }
    
}
