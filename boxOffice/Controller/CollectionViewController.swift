//
//  CollectionViewController.swift
//  boxOffice
//
//  Created by 이혜주 on 09/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    fileprivate let cellId = "celId"
    var movieList: MovieList?
    
    private let refresh = UIRefreshControl()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.alpha = 0.5
        activityIndicator.center = CGPoint(x: collectionView.bounds.size.width / 2, y: collectionView.bounds.size.height / 2 - 50)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .black
        activityIndicator.layer.cornerRadius = 15
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCollectionView()
    }
    
    func setLayout() {
        collectionView.backgroundColor = .white
        refresh.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refresh)
        collectionView.addSubview(indicator)
        indicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        let urlString = url("movies?order_type=0")
        requestData(urlString: urlString) { [weak self] (data: MovieList?, err: Error?) in
            if let error = err {
                DispatchQueue.main.async {
                    self?.showErrorAlert(error: error.localizedDescription)
                }
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.showErrorAlert(error: "")
                }
                return
            }
            
            self?.movieList = data
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.indicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func setCollectionView() {
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }
    
    func showErrorAlert(error: String) {
        self.indicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        let alertController = UIAlertController(title: "Notice", message: "데이터를 불러올 수 없습니다.\n\(error)", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "닫기", style: .destructive, handler: nil)
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let type = self.movieList?.orderType else {
            return
        }
        
        let urlString = url("movies?order_type=\(type)")
        requestData(urlString: urlString) { [weak self] (data: MovieList?, err: Error?) in
            if let error = err {
                DispatchQueue.main.async {
                    self?.showErrorAlert(error: error.localizedDescription)
                }
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.showErrorAlert(error: "")
                }
                return
            }
            
            self?.movieList = data
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                sender.endRefreshing()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    //MARK:- DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.movies.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.movie = self.movieList?.movies[indexPath.item]
        return cell
    }
    
    //MARK:- Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextController = MovieContentsTableViewController.init(style: .grouped)
        nextController.movieName = self.movieList?.movies[indexPath.item].title
        nextController.movieId = self.movieList?.movies[indexPath.item].id
        navigationController?.pushViewController(nextController, animated: true)
    }
    
}

extension CollectionViewController: MovieSortingDelegate {
    func didChangeMovieData(type: Int) {
        indicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let urlString = url("movies?order_type=\(type)")
        requestData(urlString: urlString) { [weak self] (data: MovieList?, err: Error?) in
            if let error = err {
                DispatchQueue.main.async {
                    self?.showErrorAlert(error: error.localizedDescription)
                }
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.showErrorAlert(error: "")
                }
                return
            }
            
            self?.movieList = data
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.indicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}

