//
//  GameViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 06/12/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var game = FlippingHell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        game.loadLevels()
        
        // Can use the following functionality for sizing:
        // buttonClassID.layer.cornerRadius = buttonClassID.frame.size.height/2
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "loadMenuSegue" {
            if let mvc = segue.destination as? UINavigationController {
                let lvc = mvc.children[0] as! LevelTableViewController
                lvc.levels  = game.levels
            }
        } else if segue.identifier == "loadOptionsSegue" {
            print("Options Segue")
        } else if segue.identifier == "loadAboutSegue" {
            print("About Segue")
        }
    }
    
}

@IBDesignable extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
