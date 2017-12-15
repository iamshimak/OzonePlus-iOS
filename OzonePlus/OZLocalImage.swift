//
//  OZLocalImage.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/11/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class OZLocalImage: NSObject, OZImageble {
    var name: String!
    var url: URL!
    var size: CGSize!
    var type: String!
    var commonColor: UIColor!
    var data: Data!
    
    init(commonColor:UIColor, image:UIImage, data:Data) {
        super.init()
        self.size = image.size
        self.name = generateRandomName()
        self.data = data
        self.type = imageType(image: data)
        self.commonColor = commonColor
    }
    
    func ozlocalImage() -> [String : Any] {
        return ["name" : name,
                "url" : url != nil ? url!.absoluteString : "",
                "height" : size.height,
                "width" : size.width,
                "type" : type,
                "commonColor" : commonColor.toHex ?? ""]
    }
    
    private func generateRandomName() -> String{
        return generateRandomDigits(20)
    }
    
    private func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
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
