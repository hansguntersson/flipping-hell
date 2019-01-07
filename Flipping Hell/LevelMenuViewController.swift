//
//  MenuViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 03/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class LevelMenuViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // self.navigationBar.frame.size.height = self.navigationBar.frame.size.height + 50
    }
    
    @IBAction func unwindToStageMenu(segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
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
