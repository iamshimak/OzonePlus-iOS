//
//  PhotoUploadViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/15/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit

class PhotoUploadViewController: UIViewController {

    @IBOutlet weak var imageContainerView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    public var uploadImage: OZLocalImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(data: uploadImage.data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:
    
    @IBAction func uploadAction(_ sender: Any) {
        if uploadImage != nil {
            Util.displayActivityIndicator()
            UploadManager.uploadImage(image: uploadImage!, onCompletion: { (status, error) in
                Util.removeActivityIndicator()
                
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
