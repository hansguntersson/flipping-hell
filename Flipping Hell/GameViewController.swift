//
//  GameViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 06/12/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer: AVAudioPlayer!

// ********************************** CLASS DEFINITION ********************************** //

// TODO: Acsount for ipad and larger displays
// TODO: Fix plugin error below
// TODO: Add sound effects for dismiss of win screen
// TODO: Fix visual error when unwinding from win screen to levels
// TODO: Save sequence with level, display upon selecting stars
// TODO: Check twitter link works on info.plist
/*
 
 
 Tasks:
 - Flip sound when segueing
 - Sound on/off option
 - Show sequence when clicking on star
 - Don’t show flips on level select, save for detail screen
 - Numbers not centred properly
 - Review stars screen to clarify how many levels have been won, and total stars
 
 
 Other:
  - Load base data from JSON
  - Update any records based on array of saved scores
  - When a new record is created, save / overwrite the score in memory
 
  Hyperlink error:
 
    2021-11-10 14:17:16.243791+0000 Flipping Hell[3423:586911] -canOpenURL: failed for URL: "twitter://user?screen_name=hansguntersson" - error: "This app is not allowed to query for scheme twitter"
     Message from debugger: Terminated due to signal 9
  */

class GameViewController: UIViewController {
    
    var game = FlippingHell()
    @IBOutlet var playButton: UIButton!
    
    // ********************************** SOUNDS ********************************** //
    
    let pagesoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "pageturn.mp3", ofType: nil)!)
    
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
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: self.pagesoundurl)
                    audioPlayer?.volume = 1
                    audioPlayer?.play()
                } catch {
                    print("Unable to locate audio file")
                }
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
 RESIDUAL LEVELS CUT FROM GAME BASED ON TIME
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
