//
//  OZLocalImage.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/11/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class OZLocalImage: NSObject {
    var name: String!
    var url: URL!
    var size: CGSize!
    var type: String!
    var placeHolderColor: UIColor?
    var data: Data!
    
    init(placeHolderColor:UIColor?, image:UIImage) {
        super.init()
        self.size = image.size
        self.name = "IM_007"
        self.data = UIImagePNGRepresentation(image)
        self.type = imageType(image: data)
        self.placeHolderColor = placeHolderColor
    }
    
    func ozlocalImage() -> [String : Any] {
        return ["name" : name,
                "url" : url != nil ? url!.absoluteString : "",
                "height" : size.height,
                "width" : size.width]
    }
    
    private func imageType(image: Data) -> String {
        var values = [UInt8](repeating:0, count:1)
        image.copyBytes(to: &values, count: 1)
        
        let ext: String
        switch (values[0]) {
        case 0xFF:
            ext = "image/jpg"
        case 0x89:
            ext = "image/png"
        case 0x47:
            ext = "image/gif"
        case 0x49, 0x4D :
            ext = "image/tiff"
        default:
            ext = "image/png"
        }
        
        return ext
    }
}
