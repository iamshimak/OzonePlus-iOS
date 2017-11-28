//
//  UIImageView+ImageLoader.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/27/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import Foundation
import AFNetworking

extension UIImageView {
    func imageWithURL(url: String) {
        image = nil
        Util.displayActivityIndicatorForImageView(view: self)
        DownloadManager.downloadMedia(url: url, onCompletion: { (image, error) in
            if error == nil {
                Util.removeActivityIndicator(forView: self)
                self.image = image
            }
        })
    }
}
