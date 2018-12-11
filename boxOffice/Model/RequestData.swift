//
//  RequestData.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

typealias movieListBlock = ((MovieList?, Error?) -> ())
typealias movieDataBlock = ((MovieData?, Error?) -> ())
typealias commentListBlock = ((CommentList?, Error?) -> ())

let cache: NSCache = NSCache<NSString, UIImage>()

func requestMovieList(type: Int, completion: @escaping movieListBlock) {
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=\(type)") else {
        return
    }
    
    let session: URLSession = URLSession(configuration: .default)
    
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            let apiResponse: MovieList = try JSONDecoder().decode(MovieList.self, from: data)
            completion(apiResponse, nil)
        } catch let err {
            print(err.localizedDescription)
            completion(nil, error)
        }
    }
    
    dataTask.resume()
}

func requestMovieData(id: String, completion: @escaping movieDataBlock) {
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movie?id=\(id)") else {
        return
    }
    
    let session: URLSession = URLSession(configuration: .default)
    
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            let apiResponse: MovieData = try JSONDecoder().decode(MovieData.self, from: data)
            completion(apiResponse, nil)
        } catch let err {
            print(err.localizedDescription)
            completion(nil, error)
        }
    }
    
    dataTask.resume()
}

func requestCommentList(id: String, completion: @escaping commentListBlock) {
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/comments?movie_id=\(id)") else {
        return
    }
    
    let session: URLSession = URLSession(configuration: .default)
    
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            let apiResponse: CommentList = try JSONDecoder().decode(CommentList.self, from: data)
            completion(apiResponse, nil)
        } catch let err {
            print(err.localizedDescription)
            completion(nil, err)
        }
    }
    
    dataTask.resume()
}

func getImage(url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
    let session: URLSession = URLSession(configuration: .default)
    
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            return
        }
        
        if let image = UIImage(data: data) {
            cache.setObject(image, forKey: url.absoluteString as NSString)
            completion(cache.object(forKey: url.absoluteString as NSString), nil)
        } else {
            return
        }
    }
    dataTask.resume()
}
