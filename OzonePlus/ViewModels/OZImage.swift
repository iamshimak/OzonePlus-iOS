//
//  OZImage.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/6/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OZImage: NSObject {
    var height: Double!
    var width: Double!
    var name: String!
    var url: String!
    var placeHolderColor: UIColor!
    
    init(snapshot: DataSnapshot) {
        let dic = snapshot.value as! Dictionary<String, Any>
//        height = dic["height"] as! CGFloat
//        width = dic["width"] as! CGFloat
        name = dic["name"] as! String
        url = dic["url"] as! String
        //placeHolderColor = dic[""]
    }
    
    init(dic: Dictionary<String, Any>) {
//        height = dic["height"] as! CGFloat
//        width = dic["width"] as! CGFloat
        name = dic["name"] as! String
        url = dic["url"] as! String
    }
}
