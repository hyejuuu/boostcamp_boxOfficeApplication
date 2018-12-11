//
//  MovieSortingDelegate.swift
//  boxOffice
//
//  Created by 이혜주 on 07/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import Foundation

// tableView와 collectionView에서 정렬방법이 바뀌었을 때 알려주기 위한 delegate
protocol MovieSortingDelegate: class {
    func didChangeMovieData(type: Int)
}
