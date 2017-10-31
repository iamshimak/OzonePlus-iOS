//
//  SlideInPresentationManager.swift
//  MedalCount
//
//  Created by Ahamed Shimak on 10/30/17.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class SlideInPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    
    var direction = PresentationDirection.bottom
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented,
                                                                   presenting: presenting,
                                                                   direction: direction)
        return presentationController
    }
}
