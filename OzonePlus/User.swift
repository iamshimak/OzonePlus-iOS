//
//  User.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/25/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class User: NSObject {
    
    private var firstName : String!
    private var lastName : String!
    private var userName : String!
    private var email : String!
    
    static let sharedInstance: User = {
        let instance = User()
        return instance
    }()
    
    override init() {
        super.init()
    }
}
