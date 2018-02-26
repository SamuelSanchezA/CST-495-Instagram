//
//  PhotoUploadViewController.swift
//  instagram-assignment
//
//  Created by Samuel on 2/12/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import Parse

class PhotoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoToUploadImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
    var vc: UIImagePickerController!
    var imageToUpload: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        imageToUpload = #imageLiteral(resourceName: "image_placeholder")
        photoToUploadImageView.image = imageToUpload
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let editedImage = resize(image: originalImage, newSize: CGSize(width: 300, height: 300))
        imageToUpload = editedImage
        // Do something with the images (based on your use case)
        photoToUploadImageView.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func changePhoto(_ sender: Any) {
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        Post.postUserImage(image: photoToUploadImageView.image, withCaption: captionTextView.text) {
            (success, error) in
            if success{
                print("Image upload successful!")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabCont") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
            }
            else{
                print(error?.localizedDescription)
            }
        }
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

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
