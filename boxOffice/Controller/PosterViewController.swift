//
//  PosterViewController.swift
//  boxOffice
//
//  Created by 이혜주 on 10/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

class PosterViewController: UIViewController {

    var image: UIImage?
    let gesture = UITapGestureRecognizer()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gesture.delegate = self
        setLayout()
    }
    
    func setLayout() {
        self.view.backgroundColor = .black
        self.view.addSubview(posterImageView)
        self.view.addGestureRecognizer(gesture)
        posterImageView.image = image
        
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            posterImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            posterImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
}

extension PosterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        dismiss(animated: true, completion: nil)
        return false
    }
}
