//
//  PhotoUploadViewController.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 12/7/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import ChameleonFramework

class PhotoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let imageCell = "galleryImageCell"
    private var selectedImage: OZLocalImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:
    
    @IBAction func imageSelectedAction(_ sender: Any) {
        if selectedImage != nil {
            Util.displayActivityIndicator()
            UploadManager.uploadImage(image: selectedImage!, onCompletion: { (status, error) in
                Util.removeActivityIndicator()
            })
        }
    }
    
    @IBAction func openGalleryAction(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        show(picker, sender: self)
    }
    
    // MARK: UIImagePickerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.convertImage(image: img)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func convertImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        selectedImage = OZLocalImage(commonColor: (AverageColorFromImage(image)),
                                     image:image,
                                     data:data!)
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
