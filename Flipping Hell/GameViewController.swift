//
//  GameViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 06/12/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** CLASS DEFINITION ********************************** //

class GameViewController: UIViewController {
    
    var game = FlippingHell()
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let widthValue = playButton.frame.size.height / 2.0
        // playButton.layer.cornerRadius = widthValue
        
        print(playButton.frame.height)
        print(playButton.frame.width)
        playButton.cornerCalculation(r: 0.90)
        
        // TODO: Add in score / ranking buttons and menus to the interface
        
        /*
         Summary of stars won for each type
         Stages completed, Levels completed
         Top ranking users, based on various metrics:
         - most levels won
         - most stars
         - level completed most times
         - score (based on stars)
         - most attempts
         - attempts / won ratio
         
         Should green stars indicate that you're the first person to complete a level?
         Wnat's the highest number for any number of flips?
 
        */
        
    }
    
    // ********************************** FUNCTIONS ********************************** //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GameStartSegue" {
            if let vc = segue.destination as? MainViewController {
                vc.game = self.game
                game.UpdateMainViewDelegateInstance = vc
            }
        } else if segue.identifier == "loadOptionsSegue" {
            print("Options Segue")
        }
    }
    
    @IBAction func openTwitter(_ sender: UIButton) {
        let screenName = "hansguntersson"
        let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")! as URL
        let webURL = NSURL(string: "https://twitter.com/\(screenName)")! as URL
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL, options: [:])
        } else {
            application.open(webURL, options: [:])
        }
    }
}

@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}

extension UIButton {
    func cornerCalculation(r: CGFloat) {
        self.layer.cornerRadius = self.frame.height / 2 * r
    }
}

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
