//
//  ProfileViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/6/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    private var imageCollection: [OZImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProfilePic()
        loadImages()
        initializeAppSettings()
        setCollectioViewCellSpacing()
    }
    
    @IBAction func profilePicSelected(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    
    func updateProfilePic() {
        let url : URL? = UserManager.sharedInstance.currentUser().profilePic
        
        if url != nil {
            downloadProfileImage(url: url!)
        } else {
            //profileImage.image = PersistManager.getImage(name: "profile_pic")
        }
    }
    
    func loadImages() {
        DownloadManager.downloadImages(onCompletion: { (images, error) in
            if images != nil {
                for img in images! {
                    //self.imageCollection.append(img)
                }
                self.imageCollectionView.reloadData()
            }
        })
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
        if user.fullName?.count != 0 {
            nameLabel.text = user.fullName
        } else {
            nameLabel.text = "\(user.firstName!)\n\(user.lastName!)"
        }
    }
    
    private func setCollectioViewCellSpacing() {
        // Create flow layout
        let flow = UICollectionViewFlowLayout()
        
        // Define layout constants
        let itemSpacing: CGFloat = 1.0
        let collectionViewWidth = imageCollectionView!.bounds.size.width
        let itemsInOneLine: CGFloat = 3.0
        
        // Calculate other required constants
        let width = collectionViewWidth - itemSpacing * (itemsInOneLine - 1)
        let cellWidth = floor(width / itemsInOneLine)
        let realItemSpacing = itemSpacing + (width / itemsInOneLine - cellWidth) * itemsInOneLine / (itemsInOneLine - 1)
        
        // Apply values
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.itemSize = CGSize(width: cellWidth, height: cellWidth)
        flow.minimumInteritemSpacing = realItemSpacing
        flow.minimumLineSpacing = realItemSpacing
        
        // Apply flow layout
        imageCollectionView?.setCollectionViewLayout(flow, animated: false)
    }
    
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        let imageView = cell.viewWithTag(100) as! UIImageView
        imageView.imageWithURL(url: imageCollection[indexPath.row].url)
        return cell
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
