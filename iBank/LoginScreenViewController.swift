//
//  LoginScreenViewController.swift
//  iBank
//
//  Created by VIVEKSINGH RAGHAV on 15/03/21.
//

import UIKit

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.layer.cornerRadius = 22
        userPassword.layer.cornerRadius = 22
        login.layer.cornerRadius = 22
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginPressed(_ sender: Any) {
        if userName.text == "akash" && userPassword.text == "123"{
            let vc = storyboard?.instantiateViewController(identifier: "login_vc") as! UserHomeScreenViewController
            present(vc,animated: true)
          
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
