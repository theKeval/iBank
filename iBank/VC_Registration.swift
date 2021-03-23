//
//  VC_Registration.swift
//  iBank
//
//  Created by Keval on 3/24/21.
//

import UIKit

class VC_Registration: UIViewController {
    
    // outlets
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var field_name: UITextField!
    @IBOutlet weak var field_password: UITextField!
    @IBOutlet weak var field_contact: UITextField!
    @IBOutlet weak var field_address: UITextField!
    @IBOutlet weak var picker_accType: UIPickerView!
    
    @IBOutlet weak var view_savingAcc: UIView!
    @IBOutlet weak var savingField_amount: UITextField!
    @IBOutlet weak var savingLabel_minAmount: UILabel!
    @IBOutlet weak var savingLabel_intRate: UILabel!
    
    @IBOutlet weak var view_salaryAcc: UIView!
    @IBOutlet weak var salaryField_amount: UITextField!
    @IBOutlet weak var salaryField_employer: UITextField!
    @IBOutlet weak var salaryField_salary: UITextField!
    
    @IBOutlet weak var view_fdAcc: UIView!
    @IBOutlet weak var fdField_amount: UITextField!
    @IBOutlet weak var fdField_months: UITextField!
    @IBOutlet weak var fdLabel_intRate: UILabel!
    
    // Variables
    
    var accTypes = ["Saving Account", "Salary Account", "Fixed Deposit Account"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker_accType.delegate = self
        picker_accType.dataSource = self
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

extension VC_Registration: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accTypes.count
    }
    
    
    
}
