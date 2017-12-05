//
//  DownloadManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/1/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import Firebase
import Foundation
import AFNetworking
import FirebaseDatabase

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
    
    static func storageReferenceFor(url: String) -> StorageReference {
        return Storage.storage().reference().child("images/\(url)")
    }
    
    static func downloadMedia(url: String, onCompletion: @escaping(_ :UIImage?, _ : Error?) -> Void) {
        let storageRef = storageReferenceFor(url: url)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                onCompletion(nil, error)
            } else {
                onCompletion(UIImage(data: data!), nil)
            }
        }
    }
    
    static func downloadImages(onCompletion: @escaping(_ : NSArray?, _ : Error?) -> Void) {
        let ref = Database.database().reference(withPath: "images/")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSArray
            onCompletion(value, nil)
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
