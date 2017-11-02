//
//  CashManager.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/1/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import Foundation

class PersistManager: NSObject {
    
    func getImage(name: String) -> UIImage? {
        let data = NSData(contentsOfFile: "/Document/\(name)") as Data?
        return UIImage(data: data!)
    }
    
//    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
//    NSData *data = UIImagePNGRepresentation(image);
//    [data writeToFile:filename atomically:YES];
    
    func save(image: UIImage, name: String) {
        let data = UIImagePNGRepresentation(image) as NSData?
        data?.write(toFile: name, atomically:true)
    }
}
