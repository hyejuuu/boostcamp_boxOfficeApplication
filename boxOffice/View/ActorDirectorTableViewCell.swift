//
//  ActorDirectorTableViewCell.swift
//  boxOffice
//
//  Created by 이혜주 on 10/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

// 감독/출연을 보여줄 cell
class ActorDirectorTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "감독/출연"
        return label
    }()
    
    let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let actorTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "출연"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    func setLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(directorTitleLabel)
        self.contentView.addSubview(directorLabel)
        self.contentView.addSubview(actorTitleLabel)
        self.contentView.addSubview(actorLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            directorTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            directorTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            directorTitleLabel.widthAnchor.constraint(equalToConstant: 35),
            
            directorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            directorLabel.leadingAnchor.constraint(equalTo: directorTitleLabel.trailingAnchor, constant: 10),
            directorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            actorTitleLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 10),
            actorTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            actorTitleLabel.widthAnchor.constraint(equalToConstant: 35),
            
            actorLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 10),
            actorLabel.leadingAnchor.constraint(equalTo: actorTitleLabel.trailingAnchor, constant: 10),
            actorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            actorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
