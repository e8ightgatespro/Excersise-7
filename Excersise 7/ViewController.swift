//
//  ViewController.swift
//  Excersise 7
//
//  Created by Voss, Garrett on 4/27/18.
//  Copyright © 2018 Voss, Garrett. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    var Transaction: Transaction?
    var Loan: Loan?
    var Checking: Checking?
    
    @IBOutlet weak var sgmtControl: UISegmentedControl!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtCustomerNumber: UITextField!
    @IBOutlet weak var txtInitialBalance: UITextField!
    @IBOutlet weak var txtcurrentBalance: UITextField!
    @IBOutlet weak var txtinterestRate: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        changeMode(self)
        let textFields: [UITextField] = [txtAccountNumber, txtType, txtAmount, txtCustomerNumber, txtInitialBalance, txtcurrentBalance, txtinterestRate]
        
        for textfield in textFields {
            textfield.addTarget(self, action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)), for: UIControlEvents.editingDidEnd)
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        Transaction?.accountNumber = txtAccountNumber.text
        Transaction?.type = txtType.text
        Transaction?.amount = txtAmount.text
        Loan?.accountNumber = txtAccountNumber.text
        Loan?.customerNumber = txtCustomerNumber.text
        Loan?.initialBalance = txtInitialBalance.text
        Loan?.currentBalance = txtcurrentBalance.text
        Loan?.amount = txtAmount.text
        Loan?.interestRate = txtinterestRate.text
        Checking?.accountNumber = txtAccountNumber.text
        Checking?.customerNumber = txtCustomerNumber.text
        Checking?.currentBalance = txtcurrentBalance.text
        return true
    }
    
    @IBAction func changeMode(_ sender: Any) {
        let transactionTextFields: [UITextField] = [txtAccountNumber,txtType,txtAmount]
        let loanTextFields: [UITextField] = [txtAccountNumber,txtCustomerNumber,txtInitialBalance,txtcurrentBalance,txtAmount,txtinterestRate]
        let checkingTextFields: [UITextField] = [txtCustomerNumber,txtAccountNumber,txtcurrentBalance]

        if sgmtControl.selectedSegmentIndex == 0 {
            for textField in loanTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
            }
            for textField in checkingTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
            }
            for textField in transactionTextFields{
                textField.isEnabled = true
                textField.borderStyle = UITextBorderStyle.roundedRect

            }
        }
        else if sgmtControl.selectedSegmentIndex == 1 {
            for textField in transactionTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
            }
            for textField in checkingTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
            }
            for textField in loanTextFields{
                textField.isEnabled = true
                textField.borderStyle = UITextBorderStyle.roundedRect
            }
            
        }
        else {
            for textField in transactionTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
            }
            for textField in loanTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
            }
            for textField in checkingTextFields{
                textField.isEnabled = true
                textField.borderStyle = UITextBorderStyle.roundedRect

            }
        }
    }
    
        @IBAction func saveObject(_ sender: Any) {
        if sgmtControl.selectedSegmentIndex == 0 { //Transaction
            
        } else if sgmtControl.selectedSegmentIndex == 1 { //Loan
            
        } else { //Checking
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
