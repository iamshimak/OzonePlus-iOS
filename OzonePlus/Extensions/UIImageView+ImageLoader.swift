//
//  UIImageView+ImageLoader.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/27/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import Foundation
import AFNetworking
import SDWebImage
import FirebaseStorageUI

extension UIImageView {
    func imageWithURL(url: String) {
        image = nil
        Util.displayActivityIndicatorForImageView(view: self)
        sd_setImage(with: DownloadManager.storageReferenceFor(url: url),
                    placeholderImage: nil, completion: { (image, error, cashType, reference) in
                        
                        if error == nil {
                            self.image = image
                        }
                        Util.removeActivityIndicator(forView: self)
        })
    }
    
    func imageWithDBReference(img: OZImage) {
        image = nil
        Util.displayActivityIndicatorForImageView(view: self)
        sd_setImage(with: DownloadManager.storageReferenceFor(url: img.name),
                    placeholderImage: nil, completion: { (image, error, cashType, reference) in
                        
                        if error == nil {
                            self.image = image
                        }
                        Util.removeActivityIndicator(forView: self)
        })
    }
    
    func imageWith(img: OZImage) {
        image = nil
        Util.displayActivityIndicatorForImageView(view: self)
        sd_setImage(with: img.url, placeholderImage: nil, completed: { (image, error, cashType, reference) in
            
            if error == nil {
                self.image = image
            }
            Util.removeActivityIndicator(forView: self)
        })
    }
}
