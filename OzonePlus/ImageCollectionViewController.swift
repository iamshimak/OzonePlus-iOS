//
//  ImageCollectionViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/10/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var images: [UIImage] = []
    var imageNames = ["amazing-animal-beautiful-beautifull.jpg", "vector-wallpaper-ghost-wallpapers.jpg", "8K6mZ1j.png"]
    var cellSize : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellSize = imageCollectionView.frame.size.width / 3
        
        for name in imageNames {
            DownloadManager.downloadMedia(forUser: name,onCompletion: { (image, error) in
                if image != nil {
                    self.images.append(image!)
                    self.imageCollectionView.insertItems(at: [IndexPath(item:self.images.count - 1 , section:0)])
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        let imageView = cell.viewWithTag(101) as! UIImageView!
        imageView?.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollectionView.frame.size.width / 3, height: imageCollectionView.frame.size.width / 3);
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
