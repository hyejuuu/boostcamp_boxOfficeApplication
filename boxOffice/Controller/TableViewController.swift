//
//  ViewController.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var movieList: MovieList?
    
    fileprivate let cellId = "cellId"
    private let refresh = UIRefreshControl()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.alpha = 0.5
        activityIndicator.center = CGPoint(x: tableView.bounds.size.width / 2, y: tableView.bounds.size.height / 2 - 50)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .black
        activityIndicator.layer.cornerRadius = 15
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTableView()
    }
    
    func setLayout() {
        self.tableView.backgroundColor = .white
        refresh.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refresh)
        tableView.addSubview(indicator)
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
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        }
    }
    
    func setTableView() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    // error가 발생했을 때 alert를 띄워줄 메소드
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
                self?.tableView.reloadData()
                sender.endRefreshing()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    //MARK:- DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList?.movies.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.movie = self.movieList?.movies[indexPath.row]
        return cell
    }
    
    //MARK:- Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextController = MovieContentsTableViewController.init(style: .grouped)
        nextController.movieName = self.movieList?.movies[indexPath.row].title
        nextController.movieId = self.movieList?.movies[indexPath.row].id
        navigationController?.pushViewController(nextController, animated: true)
    }
}

extension TableViewController: MovieSortingDelegate {
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
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
