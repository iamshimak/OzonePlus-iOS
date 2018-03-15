//
//  DownloadManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/1/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import Firebase
import FlickrKit
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
    
    static func downloadImages(onCompletion: @escaping(_ : Array<OZImage>?, _ : Error?) -> Void) {
        let ref = Database.database().reference(withPath: "images/")
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            guard let images = snapshot.value as? [Any],
                !images.isEmpty else {
                    onCompletion(nil, nil)
                    return
            }
            
            let ozImages = images.flatMap({ (image) -> OZImage? in
                if let image = image as? [String:Any] {
                    return OZImage(dic:image)
                } else {
                    return nil
                }
            })
            
            onCompletion(ozImages, nil)
            
        })
    }
    
    static func downloadHomeScreenImages(completion: @escaping(_ : [URL]?, _ : Error?) -> Void) {
        let flickrInteresting = FKFlickrInterestingnessGetList()
        flickrInteresting.per_page = "50"
        FlickrKit.shared().call(flickrInteresting) { (response, error) -> Void in
            DispatchQueue.main.async {
                guard let response = response,
                    let topPhotos = response["photos"] as? [String: AnyObject],
                    let photoArray = topPhotos["photo"] as? [[NSObject: AnyObject]] else {
                        completion(nil, error)
                        return
                }
                
                let urls = photoArray.flatMap({ (photoDictionary) -> URL? in
                    return FlickrKit.shared().photoURL(for: FKPhotoSize.medium640, fromPhotoDictionary: photoDictionary)
                })
                
                completion(urls, nil)
            }
        }
    }
    
    static func itemsInDB(onCompletion: @escaping(_ :Int, _ :Error?) -> Void){
        let ref = Database.database().reference(withPath: "images/")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            let imgs = (snapshot.value as? Array<Any>)?.count
            if imgs != nil {
                onCompletion(imgs!, nil)
            } else {
                onCompletion(Int(0), nil)
            }
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
