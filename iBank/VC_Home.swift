//
//  VC_Home.swift
//  iBank
//
//  Created by Keval on 3/24/21.
//

import UIKit

class VC_Home: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var label_helloGuest: UILabel!
    @IBOutlet weak var tvAccountList: UITableView!
    @IBOutlet weak var constraint_tvAccList_height: NSLayoutConstraint!
    @IBOutlet weak var btnLogout: UIButton!
    
    var accounts = [BankAccount]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let customer = loggedInCustomer {
            label_helloGuest.text = "Hello \(loggedInCustomer!.name),"
            
            if let _accounts = customer.accounts {
                if let savingAcc = _accounts.savingsAcc {
                    accounts.append(savingAcc)
                }
                
                if let salaryAcc = _accounts.salaryAcc {
                    accounts.append(salaryAcc)
                }
                
                if let fdAcc = _accounts.fixedDepositAcc {
                    accounts.append(fdAcc)
                }
            }
        }
        else {
            print("Error:- loggedInCustomer is nil")
        }
        
        tvAccountList.delegate = self
        tvAccountList.dataSource = self
        tvAccountList.tableFooterView = UIView()
        
        constraint_tvAccList_height.constant = CGFloat(accounts.count * 88)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func goBack(_ sender: Any) {
        showAlertPopup(title: "Confirmation", message: "Going back will log you out. Are you sure you want to log out?", alertStyle: .alert, actionTitles: ["Cancel", "Logout"], actionStyles: [.cancel, .default], actions: [dismissAlert(action:), logout(_:)])
    }
    
    func dismissAlert(action: UIAlertAction) {
        //
    }
    
    func alertActionLogout(action: UIAlertAction) {
        performLogout()
    }
    
    func performLogout() {
        loggedInCustomer = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        performLogout()
        
        if let cust = loggedInCustomer {
            print(cust.name)
        }
    }
    
    
}

extension VC_Home: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let acc = accounts[indexPath.row]
        let cell = tvAccountList.dequeueReusableCell(withIdentifier: "TVcell_AccountList") as! TVcell_AccountList
        
        cell.setCell(accType: acc is SavingsAccount ? "Saving Account" : (acc is SalaryAccount ? "Salary Account" : (acc is FixedDepositAccount ? "Fixed Deposit Account" : "")), accBalance: acc.accountBalance)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // perform action on account row selection
    }
    
    
}
