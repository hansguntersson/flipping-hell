//
//  GameViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 06/12/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** CLASS DEFINITION ********************************** //

// TODO: Acsount for ipad and larger displays
// TODO: Load and save logic
// TODO: Stage unlock alert
// TODO: Check twitter link works on info.plist
// TODO: Still want to log sequences even if they're not a new record?

// TODO: Decide what scores and stats are shown
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

class GameViewController: UIViewController {
    
    var game = FlippingHell()
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ********************************** SEGUES ********************************** //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoadStagesSegue" {
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! StageViewController
                lvc.game = self.game
                game.UpdateStageViewDelegateInstance = lvc
            }
        }
    }
    
    // ********************************** LINKS ********************************** //
    
    @IBAction func openTwitter(_ sender: UIButton) { // Twitter link on main screen
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

// ********************************** EXTENSIONS ********************************** //

@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
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

/*
 
 { "levelid": 7551922, "flips": 15 },
 { "levelid": 18221527, "flips": 15 },
 { "levelid": 12115083, "flips": 15 },
 { "levelid": 552944, "flips": 15 },
 { "levelid": 8771812, "flips": 15 },
 { "levelid": 14190825, "flips": 15 },
 { "levelid": 24971880, "flips": 15 },
 { "levelid": 20110960, "flips": 15 },
 { "levelid": 32365929, "flips": 15 },
 { "levelid": 340826, "flips": 15 },
 { "levelid": 33476103, "flips": 15 },
 { "levelid": 3639418, "flips": 15 },
 { "levelid": 27578956, "flips": 15 },
 { "levelid": 19549351, "flips": 15 },
 { "levelid": 3330361, "flips": 15 },
 { "levelid": 996632, "flips": 15 },
 { "levelid": 996632, "flips": 15 },
 { "levelid": 14680196, "flips": 2 },
 { "levelid": 17338398, "flips": 14 },
 { "levelid": 3582072, "flips": 12 }
 */
