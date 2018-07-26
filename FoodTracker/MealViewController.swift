//
//  ViewController.swift
//  FoodTracker
//
//  Created by 黄逸文 on 2018/7/17.
//  Copyright © 2018 charlie. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var meal:Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate=self // Handle the text field’s user input through delegate callbacks.
        
        if let meal = meal {    //editing an existing servant(meal!=nil)
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()    //hide keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title=textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled=false
    }
    
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
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button=sender as? UIBarButtonItem,button===saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default,
                   type: .debug)
            return
        }
        let name=nameTextField.text ?? ""
        let photo=photoImageView.image
        let rating=ratingControl.rating
        meal=Meal(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Action
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()    // Hide the keyboard.
        let imagePickerController = UIImagePickerController()   // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        imagePickerController.sourceType = .photoLibrary    // Only allow photos to be picked, not taken.
        imagePickerController.delegate = self   // Make sure ViewController is notified when the user picks an image.
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode=presentingViewController is UINavigationController
        if(isPresentingInAddMealMode){
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    private func updateSaveButtonState(){
        let text=nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

