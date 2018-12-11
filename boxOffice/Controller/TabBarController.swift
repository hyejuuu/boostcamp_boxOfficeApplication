//
//  TabBarController.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    weak var movieTableViewDelegate: MovieSortingDelegate?
    weak var movieCollectionViewDelegate: MovieSortingDelegate?

    lazy var sortButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings"), style: .plain, target: self, action: #selector(touchUpSortButton(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTabBar()
    }
    
    func setLayout() {
        self.view.backgroundColor = .white
        self.tabBar.barTintColor = UIColor(red: 77/255, green: 108/255, blue: 202/255, alpha: 1)
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationItem.title = "예매율순"
        
        self.navigationItem.rightBarButtonItem = sortButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setTabBar() {
        let tableViewController = TableViewController()
        tableViewController.tabBarItem.image = #imageLiteral(resourceName: "ic_list")
        tableViewController.tabBarItem.title = "Table"
        self.movieTableViewDelegate = tableViewController
        
        let layout = UICollectionViewFlowLayout()
        let halfWidth = (UIScreen.main.bounds.width - 10) / 2
        layout.itemSize = CGSize(width: halfWidth, height: 320)
        
        let collectionViewController = CollectionViewController.init(collectionViewLayout: layout)
        collectionViewController.tabBarItem.image = #imageLiteral(resourceName: "ic_collection")
        collectionViewController.tabBarItem.title = "Collection"
        self.movieCollectionViewDelegate = collectionViewController
        
        self.viewControllers = [tableViewController, collectionViewController]
    }

    // 정렬버튼을 눌렀을 때 호출되는 메소드
    @objc func touchUpSortButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        let ticketingAction = UIAlertAction(title: "예매율", style: .default, handler: { (action: UIAlertAction) in
            self.navigationItem.title = "예매율순"
            self.movieTableViewDelegate?.didChangeMovieData(type: 0)
            self.movieCollectionViewDelegate?.didChangeMovieData(type: 0)
        })
        
        let curationAction = UIAlertAction(title: "큐레이션", style: .default, handler: { (action: UIAlertAction) in
            self.navigationItem.title = "큐레이션"
            self.movieTableViewDelegate?.didChangeMovieData(type: 1)
            self.movieCollectionViewDelegate?.didChangeMovieData(type: 1)
        })
        
        let releaseAction = UIAlertAction(title: "개봉일", style: .default, handler: { (action: UIAlertAction) in
            self.navigationItem.title = "개봉일"
            self.movieTableViewDelegate?.didChangeMovieData(type: 2)
            self.movieCollectionViewDelegate?.didChangeMovieData(type: 2)
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(ticketingAction)
        alertController.addAction(curationAction)
        alertController.addAction(releaseAction)
        alertController.addAction(cancelAction)
        
        // 아이패드에서는 popoverController로 띄워준다.
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender 
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
