//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Vasco Gomes on 15/03/2017.
//  Copyright © 2017 Vasco Gomes. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0{
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.white{
        didSet{
            self.tintColor = fontColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
}
