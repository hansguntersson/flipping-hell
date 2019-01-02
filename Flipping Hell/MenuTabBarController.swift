//
//  MenuTabBarController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 02/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class MenuTabBarController: UITabBarController {

    var game = FlippingHell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.loadLevels()
        print("Test")
        let lc = self.viewControllers?[0] as! LevelTableViewController
        lc.levels = game.levels
        
        // Sync of game info etc
        // Load levels accessible, settings, data behind model etc
        // Need to move functions to model from view controller and also update the view from the model
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        /* if let barVC = segue.destination as? UITabBarController {
            print("Loaded segue")
            /*
            barVC.viewControllers?.forEach {
                if let vc = $0 as? LevelTableViewController {
                    vc.levels = game.levels
                } */
            } */
        
        /* if segue.identifier == "loadLevelsSegue" {
            if let mvc = segue.destination as? LevelTableViewController {
                mvc.levels = game.levels
            }
        }*/
    }

}
