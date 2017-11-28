//
//  ProfileViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/6/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProfilePic()
        initializeAppSettings()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func profilepicChangeAction(_ sender: Any) {
        
    }
    
    func updateProfilePic() {
        let url : URL? = UserManager.sharedInstance.currentUser().profilePic!
        
        if url != nil {
            downloadProfileImage(url: url!)
        } else {
            profileImage.image = PersistManager.getImage(name: "profile_pic")
        }
    }
    
    private func downloadProfileImage(url: URL) {
        Util.displayActivityIndicatorForImageView(view: self.profileImage)
        
        DownloadManager.downloadImage(fromUrl: url, onCompletion: { (image, error) in
            if image != nil {
                self.profileImage.image = image
                Util.removeActivityIndicator(forView: self.profileImage)
            } else {
                
            }
        })
    }
    
    private func initializeAppSettings() {
        let user = UserManager.sharedInstance.currentUser()
        nameLabel.text = "\(user.firstName!)\n\(user.lastName!)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
