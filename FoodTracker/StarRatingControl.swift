//
//  StarRatingControl.swift
//  FoodTracker
//
//  Created by Vladyslav Chornobai on 15/04/2017.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import UIKit

@IBDesignable class StarRatingControl: UIStackView {
    
    private var buttons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //MARK: properties
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            initButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            initButtons()
        }
    }

    //MARK:initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initButtons()
    }

    //MARK:private methods
    private func initButtons() {
        let bundle = Bundle(for: type(of: self))
        let filled = UIImage(named: "filled", in: bundle, compatibleWith: self.traitCollection)
        let empty = UIImage(named:"empty", in: bundle, compatibleWith: self.traitCollection)
        let highlighted = UIImage(named:"highlighted", in: bundle, compatibleWith: self.traitCollection)
        
        removeButtons()
        
        for index in 0..<starCount {
            let button = createButton()
            button.setImage(empty, for: .normal)
            button.setImage(filled, for: .selected)
            button.setImage(highlighted, for: .highlighted)
            button.setImage(highlighted, for: [.selected, .highlighted])
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            buttons.append(button)
            addArrangedSubview(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        button.addTarget(self, action: #selector(StarRatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        return button
    }
    
    private func removeButtons() {
        for button in buttons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        buttons.removeAll()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in buttons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
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
    
    //MARK:button actions
    func ratingButtonTapped(button: UIButton) {
        guard let index = buttons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(buttons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
}
