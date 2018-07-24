//
//  RatingControl.swift
//  FoodTracker
//
//  Created by 黄逸文 on 2018/7/24.
//  Copyright © 2018 charlie. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    //MARK: private methods
    private func setUpButtons(){
        let button=UIButton()
        button.backgroundColor=UIColor.red
        button.translatesAutoresizingMaskIntoConstraints=false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive=true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive=true
        
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        addArrangedSubview(button)
    }
    
    func ratingButtonTapped(button:UIButton){
        print("Button pressed 👍")
    }
    
}
