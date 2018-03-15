 //
//  ProfileView.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/2/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class ProfileView: UIView, UIImagePickerControllerDelegate {
    
    private var coverImage : UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        coverImage = UIImageView.init(frame: CGRect(x:0, y:0, width:frame.size.width, height:frame.size.height))
        addSubview(coverImage)
        
        let url : URL? = UserManager.sharedInstance.currentUser().profilePic!
        
        if url != nil {
            downloadProfileImage(url: url!)
        } else {
            //coverImage.image = PersistManager.getImage(name: "profile_pic")
        }
    }
    
    func downloadProfileImage(url: URL) {
        Util.displayActivityIndicatorForImageView(view: self)
        
        DownloadManager.downloadImage(fromUrl: url, onCompletion: { (image, error) in
            if image != nil {
                self.coverImage.image = image
                Util.removeActivityIndicator(forView: self)
            } else {
                
            }
        })
    }
    
    @objc func pickImageToUpload() {
        
    }
}
