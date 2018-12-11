//
//  RequestData.swift
//  boxOffice
//
//  Created by 이혜주 on 06/12/2018.
//  Copyright © 2018 leehyeju. All rights reserved.
//

import UIKit

let cache: NSCache = NSCache<NSString, UIImage>()

// urlString에 해당하는 데이터를 가져오기 위한 메소드
func requestData<T: Decodable>(urlString: String, completion: @escaping (T?,Error?) -> ()) {
    guard let url: URL = URL(string: urlString) else {
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
            let apiResponse: T = try JSONDecoder().decode(T.self, from: data)
            completion(apiResponse, nil)
        } catch let err {
            print(err.localizedDescription)
            completion(nil, error)
        }
    }
    
    dataTask.resume()
}

// 해당 url에서 이미지를 가져와서 cache에 저장한다
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
