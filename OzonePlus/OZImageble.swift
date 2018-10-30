//
//  OZImageProtocol.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/14/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import Foundation

protocol OZImageble {
    var oz_name: String! { get set }
    var size: CGSize! { get set }
    var oz_url: URL! { get set }
    var commonColor: UIColor! { get set }
    var type: String! { get set }
}
