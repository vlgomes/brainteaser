//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Vasco Gomes on 15/03/2017.
//  Copyright © 2017 Vasco Gomes. All rights reserved.
//

import UIKit
import pop

class AnimationEngine{
    
    class var offScreenRightPosition : CGPoint{
        return CGPoint(x: UIScreen.main.bounds.width, y: (UIScreen.main.bounds.size.height/2))
    }
    
    class var offScreenLeftPosition : CGPoint{
        return CGPoint(x:-UIScreen.main.bounds.width, y: (UIScreen.main.bounds.size.height/2))
    }
    
    class var screenCenterPosition : CGPoint{
        return CGPoint(x:(UIScreen.main.bounds.size.width/2), y: (UIScreen.main.bounds.size.height/2))
    }
    
    let ANIME_DELAY: Int = 1
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init (constraints:[NSLayoutConstraint]){
        
        for con in constraints{
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(){
        
        var index = 0
        repeat{
                
            let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                
            moveAnim?.toValue = self.originalConstants[index]
                
            moveAnim?.springBounciness = 12
            moveAnim?.springSpeed = 12
            
            if (index > 0){
                moveAnim?.dynamicsFriction += 10 + CGFloat(index)
            }
                
            let con = self.constraints[index]
            con.pop_add(moveAnim, forKey: "moveOnScreen")
                
            index += 1
                
        } while (index<self.constraints.count)
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation?, Bool) -> Swift.Void)!){
        
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        
        moveAnim?.toValue = NSValue(cgPoint: position)
        
        moveAnim?.springBounciness = 8
        moveAnim?.springSpeed = 8
        moveAnim?.completionBlock = completion
        
        view.pop_add(moveAnim, forKey: "moveToPosition")
    }
}
