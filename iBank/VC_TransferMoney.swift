//
//  VC_TransferMoney.swift
//  iBank
//
//  Created by Keval on 3/26/21.
//

import UIKit

class VC_TransferMoney: UIViewController {
    
    // Outlets
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tvAccountList: UITableView!
    @IBOutlet weak var constraint_tvAccList_height: NSLayoutConstraint!
    
    // variables
    var accounts = [BankAccount]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let customer = loggedInCustomer {
            setBankAccounts(customer: customer)
        }
        else {
            print("Error:- loggedInCustomer is nil")
        }
            
        tvAccountList.delegate = self
        tvAccountList.dataSource = self
        tvAccountList.tableFooterView = UIView()
        
        constraint_tvAccList_height.constant = CGFloat(accounts.count * 88)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - UI actions
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - helper functions
    
    func setBankAccounts(customer: CustomerDetails) {
        accounts = [BankAccount]()
        
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

}

extension VC_TransferMoney: UITableViewDelegate, UITableViewDataSource {
    
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
        // code to act on account selection change
    }
    
}
