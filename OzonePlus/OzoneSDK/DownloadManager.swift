//
//  DownloadManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/1/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import Foundation
import AFNetworking

class DownloadManager: NSObject {
    
    typealias OnDownloadImageDownload = (_ : UIImage?, _ : Error?) -> Void
    
    static func downloadImage(fromUrl: URL, onCompletion: @escaping OnDownloadImageDownload) {
        let down = AFImageDownloader()
        let urlRequest = URLRequest(url: fromUrl)
        
        down.downloadImage(for: urlRequest, success: { (request, response, responseObject) in
            onCompletion(responseObject, nil)
            PersistManager.save(image: responseObject, name: "profile_pic")
        }, failure: { (request, response, error) in
            onCompletion(nil, error)
        })
    }
    
//    static func downloadImage(fromUrl: String, onCompletion: @escaping OnDownloadImageDownload) {
//        let down = AFImageDownloader()
//        let urlRequest = URLRequest(url: URL(string: fromUrl)!)
//
//        down.downloadImage(for: urlRequest, success: { (request, response, responseObject) in
//            onCompletion(responseObject, nil)
//            PersistManager.save(image: responseObject, name: "profile_pic")
//        }, failure: { (request, response, error) in
//            onCompletion(nil, error)
//        })
//    }
}
