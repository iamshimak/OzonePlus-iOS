//
//  ImageCollectionViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/10/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    
    var imageURLs: [URL] = []
    
    private let imageViewSegue = "showImageSegue"
    fileprivate let loadingCellIdentifier = "loadingCell"
    fileprivate let imageCellIdentifier = "imageCell"
    
    private var selectedImageIndex: Int = -1
    private var selectedImage: UIImage? = nil
    
    fileprivate let imageCellInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    fileprivate let imagesPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        loadImages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    private func setupViews() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            imageCollectionView.refreshControl = refreshControl
        } else {
            imageCollectionView.addSubview(refreshControl)
        }
        
        imageCollectionView.sendSubview(toBack: refreshControl)
        addKeyboardDismissToTapView()
    }
    
    @objc private func refreshView(refreshControl: UIRefreshControl) {
        loadImages()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addKeyboardDismissToTapView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap);
    }
    
    private func loadImages() {        
        DownloadManager.downloadHomeScreenImages(completion: { (urls, error) in
            if urls != nil {
                self.imageURLs = []
                self.imageURLs = urls!
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
    
    // MARK: - SearchBar Delegate
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImageRepresentViewController {
            vc.image = selectedImage
        }
    }
    
}

extension HomeViewController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return imageURLs.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < imageURLs.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier,
                                                          for: indexPath) as! ImageCollectionViewCell
            cell.configureCell(url: imageURLs[indexPath.row])
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadingCellIdentifier,
                                                          for: indexPath)
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
        let cell = collectionView.cellForItem(at: indexPath)
        let imageView = cell?.viewWithTag(101) as! UIImageView!
        selectedImage = imageView?.image
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < imageURLs.count {
            let paddingSpace = imageCellInsets.left * (imagesPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / imagesPerRow
            
            return CGSize(width: widthPerItem, height: widthPerItem)
            
        } else {
            return CGSize(width: view.frame.width, height: 60.0)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return imageCellInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return imageCellInsets.left
    }
    
}
