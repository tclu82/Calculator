//
//  ViewController.swift
//  Calculator
//
//  Created by Zac on 9/13/16.
//  Copyright © 2016 Zac.com. All rights reserved.
//

import UIKit  // Button, textView...

class ViewController: UIViewController {
    // Default set to nil
    @IBOutlet private weak var display: UILabel! // = nil
    
    //var userIsInTheMiddleOfTyping: Bool = false
    private var userIsInTheMiddleOfTyping = false
    
    // UIButton is the argument type
    @IBAction private func touchDigit(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.darkGray
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            
            let textCurrentlyDisplay = display.text!
            // use + concatenate String
            display.text = textCurrentlyDisplay + digit
        }
        else
        {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get
        {   // extra "!" coz it might not be convertable
            return Double(display.text!)!
        }
        set
        {   // newValue uses passed "Double"
            display.text = String(newValue)
        }
    }
    
    //    private var brain: CalculatorBrain = CalculatorBrain()
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton)
    {
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(operand: displayValue)
        
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle
        {
            brain.performOperation(symbol: mathmaticalSymbol)
        }
        displayValue = brain.result
        
//                    if mathmaticalSymbol == "π"
//                    {
//                        displayValue = M_PI
//        //                display.text = String(M_PI) // M_PI
//                    }
//                    else if mathmaticalSymbol == "√"
//                    {
//                        displayValue = sqrt(displayValue)
//                    }
        
    }
}
