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
    func imageWithDBReference(img: OZImage) {
        image = nil
        Util.displayActivityIndicatorForImageView(view: self)
        sd_setImage(with: DownloadManager.storageReferenceFor(url: img.name),
                    placeholderImage: nil,
                    completion: { (image, error, cashType, reference) in
                        
                        if error == nil {
                            self.image = image
                        }
                        Util.removeActivityIndicator(forView: self)
        })
    }
    
    func imageWith(img: OZImage) {
        image = nil
        Util.displayActivityIndicatorForImageView(view: self)
        sd_setImage(with: img.url,
                    placeholderImage: nil,
                    completed: { (image, error, cashType, reference) in
            
            if error == nil {
                self.image = image
            }
            Util.removeActivityIndicator(forView: self)
        })
    }
    
    func imageWithColor(img: OZImage) {
        image = nil
        //Util.displayActivityIndicatorForImageView(view: self)
        sd_setImage(with: img.url,
                    placeholderImage: getImageWithColor(color: img.commonColor, size: self.frame.size),
                    completed: { (image, error, cashType, reference) in
                        if error == nil {
                            self.image = image
                        }
                       // Util.removeActivityIndicator(forView: self)
        })
    }
    
    private func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
