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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // ********************************** FUNCTIONS ********************************** //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GameStartSegue" {
            if let vc = segue.destination as? MainViewController {
                vc.UpdateModelDelegateInstance = self.game
                //vc.game = self.game
                vc.StageNum = self.game.currentStage
                vc.LevelNum = self.game.currentLevel
                game.UpdateMainViewDelegateInstance = vc
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

@IBDesignable extension UIView {
    @IBInspectable var cornerRadiusVIEW: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
