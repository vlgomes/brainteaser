//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Vasco Gomes on 15/03/2017.
//  Copyright © 2017 Vasco Gomes. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var emailConstraint: NSLayoutConstraint!
    @IBOutlet var passwordConstraint: NSLayoutConstraint!
    @IBOutlet var loginConstraint: NSLayoutConstraint!
    
    var animEngine : AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animEngine = AnimationEngine(constraints: [emailConstraint,passwordConstraint,loginConstraint])

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animEngine.animateOnScreen()
    }
}

