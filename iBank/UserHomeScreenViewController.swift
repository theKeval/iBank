//
//  UserHomeScreenViewController.swift
//  iBank
//
//  Created by VIVEKSINGH RAGHAV on 15/03/21.
//

import UIKit

class UserHomeScreenViewController: UIViewController {

    @IBOutlet weak var labelprint: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelprint.text = "welcome akash"
        // Do any additional setup after loading the view.
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
