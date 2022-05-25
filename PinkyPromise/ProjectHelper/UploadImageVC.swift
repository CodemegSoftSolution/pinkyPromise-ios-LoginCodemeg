//
//  UploadImageVC.swift
//  HearBK
//
//  Created by PC on 24/10/18.
//  Copyright © 2018 PC. All rights reserved.
//

import UIKit
//import PEPhotoCropEditor
//import QCropper

class UploadImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { //}, CropperViewControllerDelegate {
    
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgPicker.delegate = self
        
    }
    
    // MARK: - Upload Image
    /**
     *
     * This function is use for upload image.
     * User can select image from gallery or camera.
     * Using onCaptureImageThroughCamera function user can capture image through camera.
     * Using onCaptureImageThroughGallery function user can select image from gallery.
     * imagePickerController is delegate methode of image picker controller.
     *
     * @param
     */
    func uploadImage()
    {
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = UIColor.black
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheet.addAction(cancelButton)
        
        let cameraButton = UIAlertAction(title:"Camera", style: .default)
        { _ in
            print("Camera")
            self.onCaptureImageThroughCamera()
        }
        actionSheet.addAction(cameraButton)
        
        let galleryButton = UIAlertAction(title: "Gallery", style: .default)
        { _ in
            print("Gallery")
            self.onCaptureImageThroughGallery()
        }
        actionSheet.addAction(galleryButton)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                
            }
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc open func onCaptureImageThroughCamera()
    {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            displayToast("Your device has no camera")
        }
        else {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.allowsEditing = true
            imgPicker.sourceType = .camera
            UIViewController.top?.present(imgPicker, animated: true, completion: {() -> Void in
            })
        }
    }
    
    @objc open func onCaptureImageThroughGallery()
    {
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.allowsEditing = true
            imgPicker.sourceType = .photoLibrary
            self.present(imgPicker, animated: true, completion: {() -> Void in
                
            })
        }
    }
    
    func selectedImage(choosenImage : UIImage) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgPicker.dismiss(animated: true, completion: {() -> Void in
        })
        if let choosenImage: UIImage = info[.editedImage] as? UIImage {
            
            let croppedImage1 = compressImageView(choosenImage, to: CGSize(width: 800, height: 800))
            selectedImage(choosenImage: croppedImage1)
            self.dismiss(animated: true) {

            }
            
//            let cropper = CropperViewController(originalImage: choosenImage)
//            cropper.delegate = self
//            picker.dismiss(animated: true) {
//                self.present(cropper, animated: true, completion: nil)
//            }
        }
    }
    
//    func cropViewController(_ controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!) {
//        let croppedImage1 = compressImageView(croppedImage!, to: CGSize(width: 800, height: 800))
//        selectedImage(choosenImage: croppedImage1)
//        self.dismiss(animated: true) {
//
//        }
//    }
//    func cropViewControllerDidCancel(_ controller: PECropViewController!) {
//        self.dismiss(animated: true) {
//
//        }
//    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
//        cropper.dismiss(animated: true, completion: nil)
//
//        if let state = state,
//            let image = cropper.originalImage.cropped(withCropperState: state) {
//            selectedImage(choosenImage: image)
////            print(cropper.isCurrentlyInInitialState)
////            print(image)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



