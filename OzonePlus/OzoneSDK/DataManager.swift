//
//  DataManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/1/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import Foundation

class DataManager: NSObject {
    let sharedInstance = DataManager()
    
    private let persistManager : PersistManager
    private let downloadManager : DownloadManager
    
    override private init() {
        persistManager = PersistManager()
        downloadManager = DownloadManager()
    }
    
//    func urlForImage(url: String) -> UIImage {
//        let image = persistManager.getImage(name: url)
//        if image != nil {
//            return image
//        }
//    }
}
