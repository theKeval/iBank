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
    
    @IBOutlet weak var deposit_view: UIView!
    @IBOutlet weak var withdraw_view: UIView!
    @IBOutlet weak var transfer_view: UIView!
    @IBOutlet weak var payBill_view: UIView!
    @IBOutlet weak var accAcc_view: UIView!
    @IBOutlet weak var editProfile_view: UIView!
    @IBOutlet weak var transactions_view: UIView!
    
    var accounts = [BankAccount]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let customer = loggedInCustomer {
            label_helloGuest.text = "Hello \(loggedInCustomer!.name),\nWelcome back to iBank!"
            
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
        
        // adding tap gesture to all transactions UIView
        let gesture_deposit = UITapGestureRecognizer(target: self, action:  #selector(onDepositClick))
        deposit_view.addGestureRecognizer(gesture_deposit)
        
        let gesture_withdraw = UITapGestureRecognizer(target: self, action:  #selector(onWithdrawClicked))
        deposit_view.addGestureRecognizer(gesture_withdraw)
        
        let gesture_transfer = UITapGestureRecognizer(target: self, action:  #selector(onTransferClicked))
        deposit_view.addGestureRecognizer(gesture_transfer)
        
        let gesture_payBill = UITapGestureRecognizer(target: self, action:  #selector(onPayBillClicked))
        deposit_view.addGestureRecognizer(gesture_payBill)
        
        let gesture_addAcc = UITapGestureRecognizer(target: self, action:  #selector(onAddAccClicked))
        deposit_view.addGestureRecognizer(gesture_addAcc)
        
        let gesture_editProfile = UITapGestureRecognizer(target: self, action:  #selector(onEditProfileClicked))
        deposit_view.addGestureRecognizer(gesture_editProfile)
        
        let gesture_transactions = UITapGestureRecognizer(target: self, action:  #selector(onTransactionsClicked))
        deposit_view.addGestureRecognizer(gesture_transactions)
        
    }
    
    
    // MARK: - UI actions

    @IBAction func goBack(_ sender: Any) {
        showAlertPopup(title: "Confirmation", message: "Going back will log you out. Are you sure you want to log out?", alertStyle: .alert, actionTitles: ["Cancel", "Logout"], actionStyles: [.cancel, .destructive], actions: [dismissAlert(action:), alertActionLogout(action:)])
    }
    
    @IBAction func logout(_ sender: Any) {
        showAlertPopup(title: "Confirmation", message: "Are you sure you want to log out?", alertStyle: .alert, actionTitles: ["Cancel", "Logout"], actionStyles: [.cancel, .destructive], actions: [dismissAlert(action:), alertActionLogout(action:)])
    }
    
    
    
    
    // MARK: - Helper functions
    
    func dismissAlert(action: UIAlertAction) {
        // do nothing to just dismiss the alert
    }
    
    func alertActionLogout(action: UIAlertAction) {
        performLogout()
    }
    
    func performLogout() {
        loggedInCustomer = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onDepositClick(sender : UITapGestureRecognizer) {
        showCustomToast(message: "deposit clicked", font: UIFont.myFont())
    }
    
    @objc func onWithdrawClicked(sender: UITapGestureRecognizer) {
        
    }
    
    @objc func onTransferClicked(sender: UITapGestureRecognizer) {
        
    }
    
    @objc func onPayBillClicked(sender: UITapGestureRecognizer) {
        
    }
    
    @objc func onAddAccClicked(sender: UITapGestureRecognizer) {
        
    }
    
    @objc func onEditProfileClicked(sender: UITapGestureRecognizer) {
        
    }
    
    @objc func onTransactionsClicked(sender: UITapGestureRecognizer) {
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
