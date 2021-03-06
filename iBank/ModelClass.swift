//
//  ModelClass.swift
//  iBank
//
//  Created by Keval on 3/23/21.
//

import Foundation

class Customers: Codable {
    var customers: [CustomerDetails]
    
    init(custs: [CustomerDetails]) {
        self.customers = custs
    }
}

class CustomerDetails: Codable {
    var name: String
    var contactNo: String
    var address: String
    var password: String
    var gender: String
    
    var accounts: Accounts?
    
    init(name: String, contactNo: String, address: String, password: String, gender: String) {
        self.name = name
        self.contactNo = contactNo
        self.address = address
        self.password = password
        self.gender = gender
        
        // self.accounts = []
    }
    func addBankAccounts(accs: Accounts) {
        accounts = accs
    }
}

enum Gender {
    case male
    case female
}

enum AccountTypes {
    case savingAcc
    case salaryAcc
    case fdAcc
}

class Accounts: Codable {
    var salaryAcc: SalaryAccount?
    var savingsAcc: SavingsAccount?
    var fixedDepositAcc: FixedDepositAccount?
    
    init(salAcc: SalaryAccount? = nil, savAcc: SavingsAccount? = nil, fixAcc: FixedDepositAccount? = nil) {
        self.salaryAcc = salAcc
        self.savingsAcc = savAcc
        self.fixedDepositAcc = fixAcc
    }
}

class BankAccount: Codable {
    var accountNo: String
    var accountBalance: Double
    
    init(accNo: String, accBalance: Double) {
        self.accountNo = accNo
        self.accountBalance = accBalance
    }
    
    
    // way to encode manually due to inheritance
    
    private enum CodingKeys: String, CodingKey {
        case accountNo
        case accountBalance
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountNo, forKey: .accountNo)
        try container.encode(accountBalance, forKey: .accountBalance)
    }
    
    
    // Functions for transactions
    func addBalance(amountToAdd: Double) -> Double {
        accountBalance += amountToAdd
        return accountBalance
    }
    func deductBalance(amountToDeduct: Double) -> Double {
        accountBalance -= amountToDeduct
        return accountBalance
    }
}

class SalaryAccount: BankAccount {
    var employer: String
    var monthlySalary: Double
    
    init(accNo: String, accBalance: Double, employer: String, monthlySalary: Double) {
        self.employer = employer
        self.monthlySalary = monthlySalary
        
        super.init(accNo: accNo, accBalance: accBalance)
    }
    
    private enum CodingKeys: String, CodingKey {
        case employer
        case monthlySalary
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(employer, forKey: .employer)
        try container.encode(monthlySalary, forKey: .monthlySalary)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        employer = try container.decode(String.self, forKey: .employer)
        monthlySalary = try container.decode(Double.self, forKey: .monthlySalary)
        try super.init(from: decoder)
        
        
        // fatalError("init(from:) has not been implemented")

        // for possible correct implementation, go through the below link
        // https://stackoverflow.com/a/48281951/2049623
        //
        // https://benscheirman.com/2017/06/swift-json/
        // https://stackoverflow.com/a/48523100/2049623
    }
}

class SavingsAccount: BankAccount {
    var minBalance: Double
    var interestRate: Double
    
    init(accNo: String, accBalance: Double, minBal: Double, intRate: Double) {
        self.minBalance = minBal
        self.interestRate = intRate
        
        super.init(accNo: accNo, accBalance: accBalance)
    }
    
    private enum CodingKeys: String, CodingKey {
        case minBalance
        case interestRate
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(minBalance, forKey: .minBalance)
        try container.encode(interestRate, forKey: .interestRate)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        minBalance = try container.decode(Double.self, forKey: .minBalance)
        interestRate = try container.decode(Double.self, forKey: .interestRate)
        try super.init(from: decoder)
    }
}

class FixedDepositAccount: BankAccount {
    var termDuration: Int
    var interestRate: Double
    
    init(accNo: String, accBalance: Double, termDur: Int, intRate: Double) {
        self.termDuration = termDur
        self.interestRate = intRate
        
        super.init(accNo: accNo, accBalance: accBalance)
    }
    
    private enum CodingKeys: String, CodingKey {
        case termDuration
        case interestRate
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(termDuration, forKey: .termDuration)
        try container.encode(interestRate, forKey: .interestRate)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        termDuration = try container.decode(Int.self, forKey: .termDuration)
        interestRate = try container.decode(Double.self, forKey: .interestRate)
        try super.init(from: decoder)
    }
}


class Constants {
    static let transactionMenu = "Enter the number associated with the action, to perform that action.\n1 - Display current balance\n2 - Deposit money\n3 - Draw money\n4 - Transfer money to other bank account\n5 - Pay Electricity bill\n6 - Pay Credit card bill\n7 - Add new bank account\n8 - Show or Change customer details\n0 - Logout (go back to previous menu)"
}
