//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Vasco Gomes on 16/03/2017.
//  Copyright © 2017 Vasco Gomes. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    var currentCard: Card!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        
        self.view.addSubview(currentCard)
    }
    
    @IBAction func yesPressed(_ sender: Any) {
        if (sender as AnyObject).titleLabel??.text == "YES"{
            checkAnswer()
        } else {
            titleLbl.text = "Does this card match the previous?"
        }

        showNextCard()
    }
    @IBAction func noPressed(_ sender: Any) {
        checkAnswer()
        showNextCard()
    }
    
    func showNextCard(){
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(view: cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (POPAnimation, Bool) in
                cardToRemove.removeFromSuperview()
            })
        }
        
        //appear from the right
        if let next = createCardFromNib(){
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.isHidden{
                noBtn.isHidden = false
                yesBtn.setTitle("YES", for: UIControlState())
            }
            
            AnimationEngine.animateToPosition(view: next, position: AnimationEngine.screenCenterPosition, completion: { (POPAnimation, Bool) in
                
            })
        }
    }
    
    func createCardFromNib() -> Card? {
        return Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as? Card
    }
    
    func checkAnswer(){
        
    }
}
