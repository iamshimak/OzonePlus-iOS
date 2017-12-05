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
    
    var images: [String] = []
    
    private let imageViewSegue = "showImageSegue"
    
    private var selectedImageIndex: Int = -1
    private var selectedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cellSize = imageCollectionView.frame.size.width / 3
        
//        for name in imageNames {
//            DownloadManager.downloadMedia(forUser: name,onCompletion: { (image, error) in
//                if image != nil {
//                    self.images.append(image!)
//                    self.imageCollectionView.insertItems(at: [IndexPath(item:self.images.count - 1 , section:0)])
//                }
//            })
//        }
        setCollectioViewCellSpacing()
        loadImages()
    }
    
    func loadImages() {
        DownloadManager.downloadImages(onCompletion: { (images, error) in
            if images != nil {
                for img in images! {
                    self.images.append(img as! String)
                }
                self.imageCollectionView.reloadData()
            }
        })
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
        imageView?.imageWithURL(url: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
        let cell = collectionView.cellForItem(at: indexPath)
        let imageView = cell?.viewWithTag(101) as! UIImageView!
        selectedImage = imageView?.image
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImageRepresentViewController {
            vc.image = selectedImage
        }
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
