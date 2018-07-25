//
//  RatingControl.swift
//  FoodTracker
//
//  Created by 黄逸文 on 2018/7/24.
//  Copyright © 2018 charlie. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    private var ratingButtons=[UIButton]()
    var rating=0{
        didSet{
            updateButtonSelectedState()
        }
    }
    
    @IBInspectable var starSize:CGSize=CGSize(width:44.0,height:44.0){
        didSet {
            setUpButtons()
        }
    }
    @IBInspectable var starCount:Int=5{
        didSet{
            setUpButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    
    @objc func ratingButtonTapped(button:UIButton){
        //print("Button pressed 👍")
        guard let index=ratingButtons.index(of:button)else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating=index+1
        if selectedRating==rating{
            rating=0
        }else{
            rating=selectedRating
        }
        
    }
    
    //MARK: private methods
    private func setUpButtons(){
        let bundle=Bundle(for:type(of:self))
        let filledStar=UIImage(named:"filledStar",in:bundle,compatibleWith:self.traitCollection)
        let emptyStar=UIImage(named:"emptyStar",in:bundle,compatibleWith:self.traitCollection)
        let hightlightedStar=UIImage(named:"hightlightedStar",in:bundle,compatibleWith:self.traitCollection)
        
        
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for index in 0..<starCount{
            let button=UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(hightlightedStar, for: .highlighted)
            button.setImage(hightlightedStar, for: [.highlighted,.selected])
            button.translatesAutoresizingMaskIntoConstraints=false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true
            button.accessibilityLabel="Set \(index + 1) star rating"
            button.addTarget(self, action:#selector(ratingButtonTapped(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    func updateButtonSelectedState(){
        for(index,button)in ratingButtons.enumerated(){
            button.isSelected=index<rating
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
