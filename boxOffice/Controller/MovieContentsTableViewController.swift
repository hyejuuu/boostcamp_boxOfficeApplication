//
//  MovieContentsTableViewController.swift
//  boxOffice
//
//  Created by 이혜주 on 08/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

class MovieContentsTableViewController: UITableViewController {
    
    var commentList: CommentList?
    var movie: MovieData?
    var movieName: String?
    var movieId: String?
    
    private let cellId = "cellId"
    
    let posterTapGestureRecognizer = UITapGestureRecognizer()
    
    lazy var indicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.alpha = 0.5
        activityIndicator.center = CGPoint(x: tableView.bounds.size.width / 2, y: tableView.bounds.size.height / 2 - 50)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .black
        activityIndicator.layer.cornerRadius = 15
        return activityIndicator
    }()
    
    let headerView = MovieInfoView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let id = movieId else {
            return
        }
        
        requestMovieData(id: id) { (data, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showErrorAlert(error: error.localizedDescription)
                }
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showErrorAlert(error: "")
                }
                return
            }
            
            self.movie = data
            self.headerView.movie = data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        requestCommentList(id: id) { (data, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showErrorAlert(error: error.localizedDescription)
                }
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showErrorAlert(error: "")
                }
                return
            }
            
            self.commentList = data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posterTapGestureRecognizer.delegate = self
        setLayout()
        setTableView()
    }

    func setLayout() {
        navigationItem.title = movieName
        self.tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        tableView.addSubview(indicator)
        headerView.movieImageView.addGestureRecognizer(posterTapGestureRecognizer)
    }
    
    func setTableView() {
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func setCommentHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "한줄평"
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        
        headerView.backgroundColor = .white
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10)
            ])
        
        return headerView
    }
    
    func showErrorAlert(error: String) {
        self.indicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        let alertController = UIAlertController(title: "Notice", message: "데이터를 불러올 수 없습니다.\n\(error)", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "닫기", style: .destructive, handler: nil)
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        case 2:
            return commentList?.comments.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = self.movie else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            let cell: ContentsTableViewCell = ContentsTableViewCell()
            cell.contentsLabel.text = movie.synopsis
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell: ActorDirectorTableViewCell = ActorDirectorTableViewCell()
            cell.directorLabel.text = movie.director
            cell.actorLabel.text = movie.actor
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            guard let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CommentTableViewCell else {
                return UITableViewCell()
            }
            cell.comment = self.commentList?.comments[indexPath.row]
            cell.isUserInteractionEnabled = false
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return headerView
        case 1:
            let headerView = UIView()
            headerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return headerView
        case 2:
            let headerView = setCommentHeaderView()
            return headerView
        default:
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 325
        case 2:
            return 50
        default:
            return 0
        }
    }
}

extension MovieContentsTableViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let nextViewController = PosterViewController()
        nextViewController.image = headerView.movieImageView.image
        self.present(nextViewController, animated: true, completion: nil)
        return false
    }
}
