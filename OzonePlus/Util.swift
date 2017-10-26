//
//  Utill.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/25/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Util: NSObject {
    
    static func displayActivityIndicator() {
        let window : UIView = (UIApplication.shared.delegate?.window!)!
        displayActivityIndicatorForView(view: window)
    }
    
    static func displayActivityIndicatorForView(view: UIView) {
        let viewFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let center = CGPoint(x: (view.frame).midX, y: (view.frame).midY)
        
        let activityIndicator = NVActivityIndicatorView(frame: viewFrame, type: .ballPulse, color: UIColor.white, padding: NVActivityIndicatorView.DEFAULT_PADDING);
        activityIndicator.center = center

        let bluredView = addBlurView(view)
        
        activityIndicator.startAnimating()
        
        view.addSubview(bluredView)
        view.addSubview(activityIndicator)
    }
    
    private static func addBlurView(_ inView : UIView) -> UIVisualEffectView {
        let blurEffect : UIBlurEffect
        
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: .regular)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = inView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.6
        
        return blurEffectView
    }
    
    static func removeActivityIndicator() {
        let window : UIView = (UIApplication.shared.delegate?.window!)!
        removeActivityIndicator(forView: window)
    }
    
    static func removeActivityIndicator(forView: UIView) {
        let indicator = indicatorForView(view: forView)
        let bluredView = bluredViewForView(view: forView)
        
        if indicator != nil {
            indicator?.stopAnimating()
        }
        
        if bluredView != nil {
            bluredView?.removeFromSuperview()
        }
    }
    
    private static func indicatorForView(view: UIView) -> NVActivityIndicatorView? {
        let subviews = view.subviews.reversed()
        for view in subviews {
            if view.isKind(of: NVActivityIndicatorView.classForCoder()) {
                return view as? NVActivityIndicatorView
            }
        }
        
        return nil
    }
    
    private static func bluredViewForView(view: UIView) ->  UIVisualEffectView? {
        let subviews = view.subviews.reversed()
        for view in subviews {
            if view.isKind(of: UIVisualEffectView.classForCoder()) {
                return view as? UIVisualEffectView
            }
        }
        
        return nil
    }
}
