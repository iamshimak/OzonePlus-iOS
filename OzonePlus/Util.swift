//
//  Utill.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/25/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private struct ActivityIndicatorProperties {
    let activityIndicator : NVActivityIndicatorView!
    let activityIndicatorPlacedView : UIViewController!
    let bluredView : UIView!
}

class Util: NSObject {
    private static var ActivityIndicatorProps : ActivityIndicatorProperties!
    
    static func displayActivityIndicatorForView(vc: UIViewController) {
        let viewFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let center = CGPoint(x: (vc.view.frame).midX, y: (vc.view.frame).midY)
        
        let activityIndicator = NVActivityIndicatorView(frame: viewFrame, type: .ballPulse, color: UIColor.white, padding: NVActivityIndicatorView.DEFAULT_PADDING);
        activityIndicator.center = center

        let bluredView = addBlurView(vc.view)
        
        ActivityIndicatorProps = ActivityIndicatorProperties(activityIndicator: activityIndicator, activityIndicatorPlacedView: vc, bluredView: bluredView)
        
        activityIndicator.startAnimating()
        
        vc.view.addSubview(bluredView)
        vc.view.addSubview(activityIndicator)
    }
    
    static func removeActivityIndicator() {
        if ActivityIndicatorProps == nil {
            return
        }
        
        ActivityIndicatorProps.activityIndicator.stopAnimating()
        ActivityIndicatorProps.bluredView.removeFromSuperview()
        ActivityIndicatorProps = nil
    }
    
    static func addBlurView(_ inView : UIView) -> UIVisualEffectView {
        let blurEffect : UIBlurEffect
        
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: .regular)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        //always fill the view
        blurEffectView.frame = inView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.6
        
        return blurEffectView
    }
}
