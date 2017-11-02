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
    let sharedInstance = DownloadManager()
    
    override init() {
        //NotificationCenter.default.addObserver(self, selector: #selector(downloadImage), name: NSNotification.Name(rawValue: "DownloadImageNotification"), object: nil)
    }
    
    @objc private func downloadImage(notification: Notification) {
        
    }
    
    typealias OnDownloadImageDownload = (_ : UIImage?, _ : Error?) -> Void
    
    func downloadImage(fromUrl: String, onCompletion: @escaping OnDownloadImageDownload) {
        let down = AFImageDownloader()
        let urlRequest = URLRequest(url: URL(string: fromUrl)!)
        
        down.downloadImage(for: urlRequest, success: { (request, response, responseObject) in
            onCompletion(responseObject, nil)
        }, failure: { (request, response, error) in
            onCompletion(nil, error)
        })
    }
}
