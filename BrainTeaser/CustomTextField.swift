//
//  CustomTextField2.swift
//  BrainTeaser
//
//  Created by Vasco Gomes on 15/03/2017.
//  Copyright © 2017 Vasco Gomes. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {

    @IBInspectable var inset: CGFloat = 0
    
    @IBInspectable var cornerRadius: CGFloat = 5.0{
        didSet{
            setupView()        }
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset,dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
}
