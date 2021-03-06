//
//  Functions.swift
//  iBank
//
//  Created by Keval on 3/24/21.
//

import Foundation

// object to store all customer details including their bank accounts
var customers: Customers?
// object to store currently logged in customer
var loggedInCustomer: CustomerDetails?

// getting the saved data if exist
// var savedData = getSavedData()
var savedData: (cust: Customers?, isFirstTime: Bool) = (nil, true)

// Constants
let savingMinBal = Double(100)
let savingIntRate = Double(6)
let fdIntRate = Double(9)
var lastAccountNumber = 0

//func registerMultipleUsers() -> [CustomerDetails] {
//    var customers = [CustomerDetails]()
//    var again = false
//    repeat {
//        customers.append(registerUser())
//        print("Would you like to register more user? y/n")
//        again = readLine()! == "y"
//    }
//    while again
//
//    return customers
//}

//func registerUser() -> CustomerDetails {
//    print("Enter your name: ")
//    let name = readLine()!
//    print("Set your password: ")
//    let pass = readLine()!
//    print("Enter your contact no: ")
//    let contactNo = readLine()!
//    print("Enter your address/city: ")
//    let address = readLine()!
//
//    let customer = CustomerDetails(name: name, contactNo: contactNo, address: address, password: pass)
//    customer.addBankAccounts(accs: letAddBankAccounts())
//
//    print("Registration successful.")
//
//    return customer
//}

func letAddBankAccounts(accs: Accounts? = nil) -> Accounts {
    
    var bankAccounts = Accounts()
    if let _bankAccounts = accs {
        bankAccounts = _bankAccounts
    }

    repeat {
        print("Which account would you like to open?\n1 - Salary account\n2 - Saving account\n3 - Fixed Deposit account")
        let choice = Int(readLine()!)!

        switch choice {
            case 1:
                // open salary account
                let salAcc = createSalaryAcc()
                bankAccounts.salaryAcc = salAcc

            case 2:
                // open saving account
                let savAcc = createSavingAcc()
                bankAccounts.savingsAcc = savAcc

            case 3:
                // open fixed deposit account
                let fdAcc = createFdAcc()
                bankAccounts.fixedDepositAcc = fdAcc

            default:
                // wrong choice
                print("Sorry, incorrect input.\n")
        }

        print("\nWould you like to add more bank account? y/n")
    }
    while readLine()! == "y"

    return bankAccounts
}

//func customerLogin() -> CustomerDetails? {
//    var customer: CustomerDetails?
//    var again = false
//    repeat {
//        customer = tryLogin()
//        if let cust = customer {
//            print("Welcome \(cust.name)")
//            again = false
//        }
//        else {
//            print("Incorrect name or password. Would you like to try again? y/n")
//            again = readLine()! == "y"
//        }
//    }
//    while again
//
//    return customer
//}

func tryLogin(name: String, pass: String) -> CustomerDetails? {
    if let custs = customers?.customers {
        for cust in custs {
            if cust.name.lowercased() == name.lowercased(),
               cust.password.lowercased() == pass.lowercased() {
                // code to login
                return cust
            }
        }
    }
    return nil
}

func getAvailableAccountNumbers() -> [String] {
    var accNos = [String]()
    
    if let allCusts = customers {
        
        for cust in allCusts.customers {
            if let _salAcc = cust.accounts?.salaryAcc {
                accNos.append(_salAcc.accountNo)
            }
            
            if let _savAcc = cust.accounts?.savingsAcc {
                accNos.append(_savAcc.accountNo)
            }
            
            if let _fdAcc = cust.accounts?.fixedDepositAcc {
                accNos.append(_fdAcc.accountNo)
            }
        }
        
    }
    
    return accNos
}

func showOrEditCustDetails(cust: CustomerDetails) -> CustomerDetails {
    
    print("Below are the customer details. Enter the number associated with the detil, to change that detail.")
    print("1 - Customer name: \(cust.name)\n2 - Customer contact number: \(cust.contactNo)\n3 - Customer address/city: \(cust.address)\n4 - Customer password: \(cust.password)\n0 - Go back to previous menu")
    
    var userChoice = -1
    repeat{
        
        userChoice = Int(readLine()!)!
        switch userChoice {
        
            case 0: // go back go previous menu
                print("")
                
            case 1: // change customer name
                print("Please enter new name: ")
                if let name = readLine() {
                    cust.name = name
                }
                
            case 2: // change contact no
                print("Please enter new contact number: ")
                if let contactNo = readLine() {
                    cust.contactNo = contactNo
                }
                
            case 3: // change address/city
                print("Please enter new address/city: ")
                if let addressCity = readLine() {
                    cust.address = addressCity
                }
                
            case 4: // change password
                print("Please enter new password: ")
                if let pass = readLine() {
                    cust.password = pass
                }
                
            default:
                print("Invalid input. Please enter valid number again.")
                userChoice = -1
            
        }
        
        
    } while(userChoice == -1)
    
    return cust
}

func updateLoggedInCustomer(cust: CustomerDetails) {
    
    for i in 0..<customers!.customers.count {
        if customers!.customers[i].name == cust.name {
            customers!.customers[i] = cust
        }
    }
    
    saveJsonFile(of: getJsonString(of: customers!))
    
}

// creating bank account related functions

func generateNextAccountNumber() -> String {
    var accNo = 0
    var lastAccNo = lastAccountNumber
    let savedData = getSavedData()
    if savedData.isFirstTime {
        accNo = Int(String(format: "%03d", 1))!
    }
    else {
        let cust = savedData.cust
        if let fd = cust!.customers.last!.accounts!.fixedDepositAcc {
            if Int(fd.accountNo)! > lastAccNo {
                lastAccNo = Int(fd.accountNo)!
            }
        }
        
        if let sal = cust!.customers.last!.accounts!.salaryAcc {
            if Int(sal.accountNo)! > lastAccNo {
                lastAccNo = Int(sal.accountNo)!
            }
        }
        
        if let sav = cust!.customers.last!.accounts!.savingsAcc {
            if Int(sav.accountNo)! > lastAccNo {
                lastAccNo = Int(sav.accountNo)!
            }
        }
    }
    accNo = lastAccNo + 1
    lastAccountNumber = accNo
    return String(format: "%03d", accNo)
}

func generateAccountNumber() -> String {
    var accNo = 0
    var lastAccNo = lastAccountNumber
    let SavedData = getSavedData()
    if SavedData.isFirstTime {
        accNo = Int(String(format: "%03d", 1))!
    }
    else {
        if let custs = SavedData.cust {
            for cust in custs.customers {
                
                if let fd = cust.accounts!.fixedDepositAcc {
                    if Int(fd.accountNo)! > lastAccNo {
                        lastAccNo = Int(fd.accountNo)!
                    }
                }
                
                if let sal = cust.accounts!.salaryAcc {
                    if Int(sal.accountNo)! > lastAccNo {
                        lastAccNo = Int(sal.accountNo)!
                    }
                }
                
                if let sav = cust.accounts!.savingsAcc {
                    if Int(sav.accountNo)! > lastAccNo {
                        lastAccNo = Int(sav.accountNo)!
                    }
                }
                
            }
        }
        
    }
    
    accNo = lastAccNo + 1
    lastAccountNumber = accNo
    return String(format: "%03d", accNo)
}


func createSalaryAcc() -> SalaryAccount {
    let accNo = generateNextAccountNumber()
    print("Enter the account balance you'd like to add:")
    let accBal = Double(readLine()!)!
    print("Enter the name of your employer: ")
    let employer = readLine()!
    print("Enter your monthly salary: ")
    let monthlySal = Double(readLine()!)!

    return SalaryAccount(accNo: accNo, accBalance: accBal, employer: employer, monthlySalary: monthlySal)
}

func createSavingAcc() -> SavingsAccount {
    let accNo = generateNextAccountNumber()
    print("Minimum balance you need to maintain is: \(savingMinBal)\nAnd interest rate is: \(savingIntRate)%")

    var accBal = Double(0)
    var rep = false
    repeat {
        print("Enter the account balance you'd like to add:")
        accBal = Double(readLine()!)!
        if accBal > savingMinBal {
            rep = false
        }
        else {
            print("Please enter amount more than \(savingMinBal)")
            rep = true
        }
    }
    while rep

    return SavingsAccount(accNo: accNo, accBalance: accBal, minBal: savingMinBal, intRate: savingIntRate)
}

func createFdAcc() -> FixedDepositAccount {
    let accNo = generateNextAccountNumber()
    print("Enter the account balance you'd like to add:")
    let accBal = Double(readLine()!)!
    print("Enter the number of months as term duration for FD: ")
    let termDur = Int(readLine()!)!

    print("Interest rate for Fixed Deposit is \(fdIntRate)%")

    return FixedDepositAccount(accNo: accNo, accBalance: accBal, termDur: termDur, intRate: fdIntRate)
}

// functions regarding transactions

func displayBalance(accs: Accounts?) {
    if let accounts = accs {
        if let salAcc = accounts.salaryAcc {
            print("Balance in salary account is: \(String(format: "%.2f", salAcc.accountBalance))")
        }
        
        if let savAcc = accounts.savingsAcc {
            print("Balance in savings account is: \(String(format: "%.2f", savAcc.accountBalance))")
        }
        
        if let fdAcc = accounts.fixedDepositAcc {
            print("Balance in Fixed Deposit account is: \(String(format: "%.2f", fdAcc.accountBalance))")
        }
        
    }
}

func depositMoney(accs: Accounts?, money: Double) {
    if let accounts = accs {
        
        var salAcc: SalaryAccount?
        var savAcc: SavingsAccount?
        var fdAcc: FixedDepositAccount?
        
        var str = "In which account would you like to deposit?\n"
        if let _salAcc = accounts.salaryAcc {
            str += "1 - Salary Account\n"
            salAcc = _salAcc
        }
        
        if let _savAcc = accounts.savingsAcc {
            str += "2 - Savings Account\n"
            savAcc = _savAcc
        }
        
        if let _fdAcc = accounts.fixedDepositAcc {
            str += "3 - Fixed Deposit Account\n"
            fdAcc = _fdAcc
        }
        
        str += "press 0 to go back to previous menu"
        
        var userChoice = -1
        repeat {
            
            print(str)
            userChoice = Int(readLine()!)!
            
            switch userChoice {
                case 0: // go back to previous menu
                    print("")
                    
                case 1: // salary account
                    let newBal = salAcc?.addBalance(amountToAdd: money)
                    print("new balance in salary account is: \(String(describing: newBal))")
                    
                case 2: // savings account
                    let newBal = savAcc?.addBalance(amountToAdd: money)
                    print("new balance in savings account is: \(String(describing: newBal))")
                    
                case 3: // FD account
                    let newBal = fdAcc?.addBalance(amountToAdd: money)
                    print("new balance in Fixed Deposit account is: \(String(describing: newBal))")
                    
                default:
                    print("Invalid input. please try again")
                    userChoice = -1
            }
            
        } while(userChoice == -1)
        
    }
}

func drawMoney(accs: Accounts?, money: Double) {
    if let accounts = accs {
        
        var salAcc: SalaryAccount?
        var savAcc: SavingsAccount?
        var fdAcc: FixedDepositAccount?
        
        var str = "From which account would you like to draw money?\n"
        if let _salAcc = accounts.salaryAcc {
            str += "1 - Salary Account\n"
            salAcc = _salAcc
        }
        
        if let _savAcc = accounts.savingsAcc {
            str += "2 - Savings Account\n"
            savAcc = _savAcc
        }
        
        if let _fdAcc = accounts.fixedDepositAcc {
            str += "3 - Fixed Deposit Account\n"
            fdAcc = _fdAcc
        }
        
        str += "press 0 to go back to previous menu"
        
        var userChoice = -1
        repeat {
            
            print(str)
            userChoice = Int(readLine()!)!
            
            switch userChoice {
                case 0: // go back to previous menu
                    print("")
                    
                case 1: // salary account
                    if let _salAcc = salAcc {
                        if _salAcc.accountBalance > money {
                            print("You withdraw \(money) amount.")
                            print("new balance in salary account is \(_salAcc.deductBalance(amountToDeduct: money))")
                        }
                    }
                    
                case 2: // savings account
                    if let _savAcc = savAcc {
                        if _savAcc.accountBalance > money {
                            print("You withdraw \(money) amount.")
                            print("new balance in savings account is \(_savAcc.deductBalance(amountToDeduct: money))")
                        }
                    }
                    
                case 3: // FD account
                    if let _fdAcc = fdAcc {
                        if _fdAcc.accountBalance > money {
                            print("You withdraw \(money) amount.")
                            print("new balance in Fixed Deposit account is \(_fdAcc.deductBalance(amountToDeduct: money))")
                        }
                    }
                    
                default:
                    print("Invalid input. please try again")
                    userChoice = -1
            }
            
        } while(userChoice == -1)
        
        
    }
}

func transferMoney(accs: Accounts?) {
    if let accounts = accs {
        
        var salAcc: SalaryAccount?
        var savAcc: SavingsAccount?
        var fdAcc: FixedDepositAccount?
        
        var str = "From which account would you like to transfer?\n"
        if let _salAcc = accounts.salaryAcc {
            str += "1 - Salary Account\n"
            salAcc = _salAcc
        }
        
        if let _savAcc = accounts.savingsAcc {
            str += "2 - Savings Account\n"
            savAcc = _savAcc
        }
        
        if let _fdAcc = accounts.fixedDepositAcc {
            str += "3 - Fixed Deposit Account\n"
            fdAcc = _fdAcc
        }
        
        str += "press 0 to go back to previous menu"
        
        var userChoice = -1
        repeat {
            
            print(str)
            userChoice = Int(readLine()!)!
            
            switch userChoice {
                case 0: // go back to previous menu
                    print("")
                    
                case 1: // salary account
                    if let _salAcc = salAcc {
                        print("You have \(String(format: "%.2f", _salAcc.accountBalance)) amount in your Salary account.\nHow much money would you like to transfer?")
                        let money = Double(readLine()!)!
                        
                        if money < _salAcc.accountBalance {
                            // addToBeneficiary(money: money)
                            let amount = _salAcc.deductBalance(amountToDeduct: money)
                            print("New balance in \(loggedInCustomer!.name)'s salary account is \(amount)")
                            print("Transfer Successful !")
                        }
                        
                    }
                    
                case 2: // savings account
                    if let _savAcc = savAcc {
                        print("You have \(String(format: "%.2f", _savAcc.accountBalance)) amount in your Savings account.\nHow much money would you like to transfer?")
                        let money = Double(readLine()!)!
                        
                        if money < _savAcc.accountBalance {
                            // addToBeneficiary(money: money)
                            let amount = _savAcc.deductBalance(amountToDeduct: money)
                            print("New balance in \(loggedInCustomer!.name)'s Savings account is \(amount)")
                            print("Transfer Successful !")
                        }
                    }
                    
                case 3: // FD account
                    if let _fdAcc = fdAcc {
                        print("You have \(String(format: "%.2f", _fdAcc.accountBalance)) amount in your Fixed Diposit account.\nHow much money would you like to transfer?")
                        let money = Double(readLine()!)!
                        
                        if money < _fdAcc.accountBalance {
                            // addToBeneficiary(money: money)
                            let amount = _fdAcc.deductBalance(amountToDeduct: money)
                            print("New balance in \(loggedInCustomer!.name)'s Fixed Deposit account is \(amount)")
                            print("Transfer Successful !")
                        }
                    }
                    
                default:
                    print("Invalid input. please try again")
                    userChoice = -1
            }
            
        } while(userChoice == -1)
        
    }
}

func addToBeneficiary(money: Double, accToTransfer: String) {
    
//    print("Enter the account number in which you would like to transfer money.")
//    print("Available account numbers are: \(getAvailableAccountNumbers())")
//    let accToTransfer = readLine()!
    
    for item in customers!.customers {
        
        if let acc = item.accounts?.salaryAcc {
            if acc.accountNo == accToTransfer {
                let amount = acc.addBalance(amountToAdd: money)
                print("New balance in \(item.name)'s salary account is: \(amount)")
                break
            }
        }
        
        if let acc = item.accounts?.savingsAcc {
            if acc.accountNo == accToTransfer {
                let amount = acc.addBalance(amountToAdd: money)
                print("New balance in \(item.name)'s savings account is: \(amount)")
                break
            }
        }
        
        if let acc = item.accounts?.fixedDepositAcc {
            if acc.accountNo == accToTransfer {
                let amount = acc.addBalance(amountToAdd: money)
                print("New balance in \(item.name)'s fixed deposit account is: \(amount)")
                break
            }
        }
        
    }
    
}

enum UtilityBills: String {
    case electricityBill = "Electricity Bill"
    case creditCardBill = "Credit card Bill"
}

func processUtilityPayment(utilityType: UtilityBills, accName: String, acc: BankAccount) {
    print("Available balance in your \(accName) is \(acc.accountBalance). Enter the amount of bill you'd like to pay:")
    
    var again = false
    repeat {
        let billAmount = Double(readLine()!)!
        if billAmount < acc.accountBalance {
            print("You have successfully paid your \(utilityType.rawValue).")
            print("new balance in your salary account is \(acc.deductBalance(amountToDeduct: billAmount))")
            
            again = false
        }
        else {
            print("You only have \(acc.accountBalance) amount in your bank, please enter less amount than that:")
            again = true
        }
    } while(again)
}

func payUtilityBills(accs: Accounts?, utilityType: UtilityBills) {
    if let accounts = accs {
        
        var salAcc: SalaryAccount?
        var savAcc: SavingsAccount?
        var fdAcc: FixedDepositAccount?
        
        var str = "From which account would you like to pay your \(utilityType.rawValue)?\n"
        
        if let _salAcc = accounts.salaryAcc {
            str += "1 - Salary Account\n"
            salAcc = _salAcc
        }
        
        if let _savAcc = accounts.savingsAcc {
            str += "2 - Savings Account\n"
            savAcc = _savAcc
        }
        
        if let _fdAcc = accounts.fixedDepositAcc {
            str += "3 - Fixed Deposit Account\n"
            fdAcc = _fdAcc
        }
        
        str += "press 0 to go back to previous menu"
        
        var userChoice = -1
        repeat {
            
            print(str)
            userChoice = Int(readLine()!)!
            
            switch userChoice {
                case 0: // go back to previous menu
                    print("")
                    
                case 1: // salary account
                    if let _salAcc = salAcc {
                        processUtilityPayment(utilityType: utilityType, accName: "Salary account", acc: _salAcc)
                    }
                    
                case 2: // savings account
                    if let _savAcc = savAcc {
                        processUtilityPayment(utilityType: utilityType, accName: "Savings account", acc: _savAcc)
                    }
                    
                case 3: // FD account
                    if let _fdAcc = fdAcc {
                        processUtilityPayment(utilityType: utilityType, accName: "Fixed Diposit account", acc: _fdAcc)
                    }
                    
                default:
                    print("Invalid input. please try again")
                    userChoice = -1
            }
            
        } while(userChoice == -1)
        
    }
}


// IMPORTANT - This function is to perform all the transactions
// for logged in customer
func showAndPerformTransactions() {
    var userChoice = -1
    repeat {
        
        print(Constants.transactionMenu)
        userChoice = Int(readLine()!)!
        
        switch userChoice {
            case 0: // logout (go back to previous menu)
                loggedInCustomer = nil
                print("Logout successful")
        
            case 1: // Display current balance
                displayBalance(accs: loggedInCustomer!.accounts)
                userChoice = -1     // set -1 to again show the transaction menu

            case 2: // Deposit money
                print("Please add the amount to deposit: ")
                let amount = Double(readLine()!)!
                depositMoney(accs: loggedInCustomer!.accounts, money: amount)
                
                updateData()
                userChoice = -1

            case 3: // draw money
                print("Please enter the amount to draw: ")
                let amount = Double(readLine()!)!
                drawMoney(accs: loggedInCustomer!.accounts, money: amount)
                
                updateData()
                userChoice = -1

            case 4: // transfer moeny to other bank accounts
                transferMoney(accs: loggedInCustomer!.accounts)
                
                updateData()
                userChoice = -1

            case 5: // pay electricity bills
                payUtilityBills(accs: loggedInCustomer!.accounts, utilityType: UtilityBills.electricityBill)
                
                updateData()
                userChoice = -1
                
            case 6: // pay credit card bills
                payUtilityBills(accs: loggedInCustomer!.accounts, utilityType: UtilityBills.creditCardBill)
                
                updateData()
                userChoice = -1

            case 7: // add new bank account
                let accounts = loggedInCustomer!.accounts
                loggedInCustomer!.addBankAccounts(accs: letAddBankAccounts(accs: accounts))
                
                updateData()
                userChoice = -1

            case 8: // show or change customer details
                loggedInCustomer = showOrEditCustDetails(cust: loggedInCustomer!)
                
                updateData()
                userChoice = -1

            default:
                print("Incorrect input. Please enter valid action number")
                userChoice = -1
        }
        
        print("\n")     // just adding a line break to pretify the command line
    } while(userChoice == -1)

}

func updateData() {
    var jsonStr = ""
    for i in 0..<customers!.customers.count {
        if customers!.customers[i].name == loggedInCustomer!.name {
            customers!.customers[i] = loggedInCustomer!
        }
    }
    
    jsonStr = getJsonString(of: customers!)
    
    saveJsonFile(of: jsonStr)
}

// for development purpose
func showJson() {
    let json = getJsonString(of: customers!)
    print(json)
}

