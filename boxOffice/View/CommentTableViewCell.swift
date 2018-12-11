//
//  CommentTableViewCell.swift
//  boxOffice
//
//  Created by 이혜주 on 10/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

// 한줄평을 보여줄 cell
class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var commentContentsLabel: UILabel!
    @IBOutlet weak var starRatingStackView: UIStackView!
    
    var starImageView: [UIImageView] = []
    
    var comment: Comment? {
        didSet {
            guard let comment = comment else {
                return
            }

            let date: Date = Date(timeIntervalSince1970: comment.timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            setStarRatingView()
            
            writerLabel.text = comment.writer
            timestampLabel.text = dateFormatter.string(from: date)
            commentContentsLabel.text = comment.contents
        }
    }
    
    func setStarRatingView() {
        guard let rating = comment?.rating else {
            return
        }
        
        starImageView = starRatingStackView.arrangedSubviews.compactMap {
            return $0 as? UIImageView
        }
        
        for index in starImageView.indices {
            if Float(rating/2) > Float(index+1) {
                starImageView[index].image = #imageLiteral(resourceName: "ic_star_large_full")
            } else if Float(rating/2) < Float(index+1) && Float(rating/2) > Float(index) {
                starImageView[index].image = #imageLiteral(resourceName: "ic_star_large_half")
            } else {
                starImageView[index].image = #imageLiteral(resourceName: "ic_star_large")
            }
        }
    }
}
