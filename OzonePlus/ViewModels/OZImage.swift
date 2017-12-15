//
//  OZImage.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/6/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OZImage: NSObject, OZImageble {
    var name: String!
    var size: CGSize!
    var url: URL!
    var type: String!
    var commonColor: UIColor!
    
    init(snapshot: DataSnapshot) {
        let dic = snapshot.value as! Dictionary<String, Any>
        name = dic["name"] as! String
        url = dic["url"] as! URL
    }
    
    init(dic: Dictionary<String, Any>) {
        name = dic["name"] as! String
        url = URL(string:dic["url"] as! String)
        commonColor = UIColor(hex:(dic["commonColor"] as! String))
        type = dic["type"] as! String
        
        let height = dic["height"] as! Double
        let width = dic["width"] as! Double
        size = CGSize(width: height, height: width)
    }
}
