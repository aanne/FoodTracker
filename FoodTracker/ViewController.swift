//
//  ViewController.swift
//  FoodTracker
//
//  Created by 黄逸文 on 2018/7/17.
//  Copyright © 2018 charlie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLable: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate=self // Handle the text field’s user input through delegate callbacks.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()    //hide keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLable.text=textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else { //You want to use the original.
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
        photoImageView.image = selectedImage    // Set photoImageView to display the selected image.
        dismiss(animated: true, completion: nil)    // Dismiss the picker.
    }
    
    //MARK: Action
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()    // Hide the keyboard.
        let imagePickerController = UIImagePickerController()   // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        imagePickerController.sourceType = .photoLibrary    // Only allow photos to be picked, not taken.
        imagePickerController.delegate = self   // Make sure ViewController is notified when the user picks an image.
        present(imagePickerController, animated: true, completion: nil)
    }
}

