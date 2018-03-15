//
//  ImageCollectionViewCell.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 3/15/18.
//  Copyright © 2018 Ahamed Shimak. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    public func configureCell(url: URL) {
        imageView.imageWith(url: url)
    }
    
}
