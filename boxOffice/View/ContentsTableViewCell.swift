//
//  ContentsTableViewCell.swift
//  boxOffice
//
//  Created by 이혜주 on 10/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

class ContentsTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "줄거리"
        return label
    }()
    
    let contentsLabel: UILabel = {
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
        self.contentView.addSubview(contentsLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            contentsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            contentsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            contentsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
