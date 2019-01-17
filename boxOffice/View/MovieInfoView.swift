//
//  MovieInforView.swift
//  boxOffice
//
//  Created by 이혜주 on 10/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//
import UIKit

// 해당 영화정보를 보여주는 화면에서 headerView로 쓰일 View
class MovieInfoView: UIView {
    
    private let xibName = "MovieInfoView"
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    @IBOutlet weak var movieGradeImageView: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieUserRatingLabel: UILabel!
    @IBOutlet weak var movieAudienceLabel: UILabel!
    @IBOutlet weak var starRatingStackView: UIStackView!
    
    var starImageView: [UIImageView] = []
    
    var movie: MovieData? {
        didSet {
            didSetMovie()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func didSetMovie() {
        guard let movie = self.movie, let url = URL(string: movie.image) else {
            return
        }
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        } else {
            getImage(url: url) { [weak self] (image, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    self?.movieImageView.image = cache.object(forKey: url.absoluteString as NSString)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.setStarRatingView()
            self.movieTitleLabel.text = movie.title
            self.movieGenreLabel.text = "\(movie.genre)/\(movie.duration)분"
            self.movieReleaseLabel.text = "\(movie.date) 개봉"
            self.movieRatingLabel.text = "\(movie.reservationGrade)위 \(movie.reservationRate)%"
            self.movieUserRatingLabel.text = "\(movie.userRating)"
            self.movieAudienceLabel.text = "\(movie.audience.formattedWithSeparator)"
            self.movieGradeImageView.image = movie.getGradeImage()
        }
    }
    
    func setStarRatingView() {
        guard let rating = movie?.userRating else {
            return
        }
        
        starImageView = starRatingStackView.arrangedSubviews.compactMap {
            guard let image = $0 as? UIImageView else {
                return UIImageView()
            }
            return image
        }
        
        for index in 1..<6 {
            if Float(rating/2) > Float(index) {
                starImageView[index].image = #imageLiteral(resourceName: "ic_star_large_full")
            } else if Float(rating/2) < Float(index) && Float(rating/2) > Float(index-1) {
                starImageView[index].image = #imageLiteral(resourceName: "ic_star_large_half")
            } else {
                starImageView[index].image = #imageLiteral(resourceName: "ic_star_large")
            }
        }
        
    }
}
