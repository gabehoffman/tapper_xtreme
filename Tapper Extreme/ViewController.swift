//
//  ViewController.swift
//  Tapper Extreme
//
//  Created by Gabe at Work on 3/23/16.
//  Copyright © 2016 Gabe Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Properties
    var maxTaps: Int = 0
    var currentTaps: Int = 0
    
    
    // Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var howManyTapsTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var tapBtn: UIButton!
    @IBOutlet weak var tapsLbl: UILabel!
    
    @IBAction func onCoinTapped(sender: UIButton!) {
        currentTaps += 1
        updateTabsLbl()
        
        let screenWidth = Int(self.view.bounds.width - tapBtn.bounds.width)
        let halfscreen = screenWidth / 2
        let randomXConstant = Int(arc4random_uniform(UInt32(screenWidth))) - halfscreen
        let screenHeight = Int(self.view.bounds.height - tapBtn.bounds.height)
        let randomYConstant = Int(arc4random_uniform(UInt32(screenHeight)))
        moveTapBtn(randomXConstant, y: randomYConstant)
        
        if isGameOver() {
            restartGame()
            moveTapBtn(20, y: 0)
        }
    }
    
    @IBAction func onPlayBtnPressed(sender: UIButton!) {
       
        if (howManyTapsTxt.text != nil) && (howManyTapsTxt.text != "") {
            // Hide Start Screen Controls
            logoImageView.hidden = true
            playBtn.hidden = true
            howManyTapsTxt.hidden = true
            
            // Show Tap Screen Controls
            tapBtn.hidden = false
            tapsLbl.hidden = false
            
            maxTaps = Int(howManyTapsTxt.text!)!
            currentTaps = 0
            
            updateTabsLbl()
        }
    }
    
    func restartGame() {
        maxTaps = 0
        howManyTapsTxt.text = ""
        
        // Show Start Screen Controls
        logoImageView.hidden = false
        playBtn.hidden = false
        howManyTapsTxt.hidden = false
        
        // Hide Tap Screen Controls
        tapBtn.hidden = true
        tapsLbl.hidden = true
    }
    
    
    func updateTabsLbl() {
        tapsLbl.text = "\(currentTaps) Tabs"
    }
    
    func isGameOver() -> Bool {
        if currentTaps >= maxTaps {
            return true
        } else {
            return false
        }
    }
    
    func moveTapBtn(x: Int, y: Int) {
        for c in self.view.constraints {
            if c.firstItem === tapBtn && c.firstAttribute == NSLayoutAttribute.CenterX {
                self.view.layoutIfNeeded()
                UIView.animateWithDuration(0.5, animations: {
                    c.constant = CGFloat(x)
                    self.view.layoutIfNeeded()
                })
            }
            
            if c.firstItem === tapBtn && c.firstAttribute == NSLayoutAttribute.Top {
                self.view.layoutIfNeeded()
                UIView.animateWithDuration(0.5, animations: {
                    c.constant = CGFloat(y)
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}

