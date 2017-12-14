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
    var size: CGSize!
    var name: String!
    var url: URL!
    var placeHolderColor: UIColor!
    
    init(snapshot: DataSnapshot) {
        let dic = snapshot.value as! Dictionary<String, Any>
        name = dic["name"] as! String
        url = dic["url"] as! URL
        //placeHolderColor = dic[""]
    }
    
    init(dic: Dictionary<String, Any>) {
        name = dic["name"] as! String
        url = URL(string:dic["url"] as! String)
    }
}
