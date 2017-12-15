//
//  ImageCollectionViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/10/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    
    var images: [OZImage] = []
    
    private let imageViewSegue = "showImageSegue"
    
    private var selectedImageIndex: Int = -1
    private var selectedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCollectioViewCellSpacing()
        setupViews()
        loadImages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    private func setCollectioViewCellSpacing() {
        // Create flow layout
        let flow = UICollectionViewFlowLayout()
        
        // Define layout constants
        let itemSpacing: CGFloat = 1.0
        let collectionViewWidth = self.view.bounds.size.width
        let itemsInOneLine: CGFloat = 3.0
        
        // Calculate other required constants
        let width: CGFloat = collectionViewWidth - itemSpacing * (itemsInOneLine - 1)
        let cellWidth = width / itemsInOneLine
        let realItemSpacing = itemSpacing + (width / itemsInOneLine - cellWidth) * itemsInOneLine / (itemsInOneLine - 1)
        
        // Apply values
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.itemSize = CGSize(width: cellWidth, height: cellWidth)
        flow.minimumInteritemSpacing = realItemSpacing
        flow.minimumLineSpacing = realItemSpacing
        
        // Apply flow layout
        imageCollectionView?.setCollectionViewLayout(flow, animated: false)
    }
    
    private func setupViews() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        view.sendSubview(toBack: refreshControl)
        
        if #available(iOS 10.0, *) {
            imageCollectionView.refreshControl = refreshControl
        } else {
            imageCollectionView.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshView(refreshControl: UIRefreshControl) {
        loadImages()
    }
    
    private func loadImages() {
        DownloadManager.downloadImages(onCompletion: { (images, error) in
            if images != nil {
                self.images = []
                for img in images! {
                    self.images.append(img)
                }
                self.imageCollectionView.reloadData()
            }
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        let imageView = cell.viewWithTag(101) as! UIImageView!
        imageView?.imageWithColor(img: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
        let cell = collectionView.cellForItem(at: indexPath)
        let imageView = cell?.viewWithTag(101) as! UIImageView!
        selectedImage = imageView?.image
    }
    
    // MARK: - SearchBar Delegate
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
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
