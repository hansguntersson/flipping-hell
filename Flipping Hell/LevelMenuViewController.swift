//
//  MenuViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 03/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

// ********************************** CLASS DEFINITION ********************************** //

import UIKit

class LevelMenuViewController: UINavigationController {
    
    var LevelSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // self.navigationBar.frame.size.height = self.navigationBar.frame.size.height + 50
    }
    
    @IBAction func goBackToOneButtonTapped(_ sender: UIButton) {
        LevelSelected = Int(sender.currentTitle ?? "0")! - 1
        performSegue(withIdentifier: "unwindFromLevel", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.destination)
        if segue.identifier == "unwindFromLevel" {
            print(segue.destination)
            if let vc = segue.destination as? MainViewController {
                print(vc.LevelNum)
                vc.LevelNum = LevelSelected
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
