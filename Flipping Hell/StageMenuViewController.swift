//
//  StageMenuViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class StageMenuViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToMainMenuFromStages(segue: UIStoryboardSegue) {
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
