//
//  ImageRepresentViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 11/27/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class ImageRepresentViewController: UIViewController {
    
    public var image: UIImage! = nil
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSettings()
    }
    
    private func initializeSettings() {
        if image != nil {
            imageView.image = image
            imageViewHeightConstraint.constant = image.size.height
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
