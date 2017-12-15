//
//  UploadManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/7/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import Photos
import Firebase
import AFNetworking
import FirebaseDatabase

class UploadManager: NSObject {
    
    static func storageReferenceFor(url: String) -> StorageReference {
        return Storage.storage().reference().child("images/\(url)")
    }
    
    static func databaseRefference() -> DatabaseReference {
        return Database.database().reference(withPath: "images/")
    }
    
    static func uploadImage(image: OZLocalImage, onCompletion:@escaping (_ :String?, _ :Error?) -> Void) {
        let metaData = StorageMetadata()
        metaData.contentType = image.type
        let storageRef = storageReferenceFor(url: image.name)
        
        storageRef.putData(image.data!, metadata: metaData) { (metadata, error) in
            if error == nil {
                image.url = metadata!.downloadURLs!.first
                updateImageInfo(image: image, onComplete:{ (success, error) in
                    if success! {
                        onCompletion("Success", nil)
                    } else {
                        onCompletion(nil, error)
                    }
                })
            } else {
                onCompletion(nil, error)
            }
        }
    }
    
    static func updateImageInfo(image: OZLocalImage, onComplete:@escaping (_ success :Bool?, _ error :Error?) -> Void) {
        DownloadManager.itemsInDB(onCompletion: { (count: Int?, error) in
            if error == nil {
                let ref = databaseRefference()
                image.name = ref.childByAutoId().key
                let post = image.ozlocalImage()
                let childUpdates = ["\(count!.description)" : post]
                ref.updateChildValues(childUpdates, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        onComplete(true, nil)
                    } else {
                        onComplete(false, error)
                    }
                })
            } else {
                onComplete(false, error)
            }
        })
    }
    
    private static func dataForUrl(url: URL, onCompletion:@escaping (_ :URL?, _ :Data?) -> Void){
        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
        if let photo = fetchResult.firstObject {
            PHImageManager.default().requestImage(for: photo, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: nil) {
                image, info in
                onCompletion(info!["PHImageFileURLKey"] as? URL, UIImagePNGRepresentation(image!))
            }
        }
    }
}
