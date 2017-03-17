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
    @IBOutlet var timerLbl: UILabel!
    
    @IBOutlet var correctLbl: UILabel!
    @IBOutlet var incorrectLbl: UILabel!
    
    var seconds = 0
    var timer = Timer()
    var correct = 0
    var incorrect = 0
    
    var currentCard: Card!
    var previousCard : Card!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        
        if previousCard == nil{
            previousCard = currentCard
        }
        
        self.view.addSubview(currentCard)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameVC.updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func yesPressed(_ sender: Any) {
        if (sender as AnyObject).titleLabel??.text == "YES"{
            checkAnswer(check: true)
        } else {
            titleLbl.text = "Does this card match the previous?"
        }

        showNextCard()
    }
    @IBAction func noPressed(_ sender: Any) {
        checkAnswer(check: false)
        showNextCard()
    }
    
    func updateTimer(){
        self.seconds += 1
        self.timerLbl.text = "\(seconds)"
        
        //stop the game after 1 minute
        if self.seconds == 10{
            stopWatch()
        }
    }
    
    func stopWatch(){
        timer.invalidate()
        seconds = 0
        self.timerLbl.text = "\(seconds)"
        
        self.correctLbl.text = "Correct Answers : \(correct)"
        self.incorrectLbl.text = "Incorrect Answers : \(incorrect)"
        
        currentCard.removeFromSuperview()
        
        
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
    
    func checkAnswer(check: Bool){
        
        print ("PREVIOUS CARD - \(previousCard.currentShape)")
        print ("CURRENT CARD - \(currentCard.currentShape)")
        
        //se foi premido sim e o cartão é o mesmo , incremente correto
        if check && previousCard.currentShape == currentCard.currentShape{
            self.correct += 1
        } else if check && previousCard.currentShape != currentCard.currentShape{
            self.incorrect += 1
        } else if !check && previousCard.currentShape == currentCard.currentShape{
            self.incorrect += 1
        } else if !check && previousCard.currentShape != currentCard.currentShape{
            self.correct += 1
        }
        
        
        print ("ANSWERS : Correct -> \(correct) Incorrect -> \(incorrect)")
    }
}
