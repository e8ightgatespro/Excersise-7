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
    
    var currentTransaction: Transaction?
    var currentLoan: Loan?
    var currentChecking: Checking?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
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
        currentTransaction?.accountNumber = txtAccountNumber.text
        currentTransaction?.type = txtType.text
        currentTransaction?.amount = txtAmount.text
        currentLoan?.accountNumber = txtAccountNumber.text
        currentLoan?.customerNumber = txtCustomerNumber.text
        currentLoan?.initialBalance = txtInitialBalance.text
        currentLoan?.currentBalance = txtcurrentBalance.text
        currentLoan?.amount = txtAmount.text
        currentLoan?.interestRate = txtinterestRate.text
        currentChecking?.accountNumber = txtAccountNumber.text
        currentChecking?.customerNumber = txtCustomerNumber.text
        currentChecking?.currentBalance = txtcurrentBalance.text
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
                textField.text = ""
            }
            for textField in checkingTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
                textField.text = ""
            }
            for textField in transactionTextFields{
                textField.isEnabled = true
                textField.borderStyle = UITextBorderStyle.roundedRect
                textField.text = ""
            }
        }
        else if sgmtControl.selectedSegmentIndex == 1 {
            for textField in transactionTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
                textField.text = ""
            }
            for textField in checkingTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
                textField.text = ""
            }
            for textField in loanTextFields{
                textField.isEnabled = true
                textField.borderStyle = UITextBorderStyle.roundedRect
                textField.text = ""
            }
            
        }
        else {
            for textField in transactionTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
                textField.text = ""
            }
            for textField in loanTextFields{
                textField.isEnabled = false
                textField.borderStyle = UITextBorderStyle.none
                textField.text = ""
            }
            for textField in checkingTextFields{
                textField.isEnabled = true
                textField.borderStyle = UITextBorderStyle.roundedRect
                textField.text = ""
            }
        }
    }
    
        @IBAction func saveObject(_ sender: Any) {
        if sgmtControl.selectedSegmentIndex == 0 { //Transaction
            let type = "Transaction"
            if currentTransaction == nil {
                let context = appDelegate.persistentContainer.viewContext
                currentTransaction = Transaction(context: context)
            }
            appDelegate.saveContext()
            changeMode(self)
            alertObjectSaved(Type: type)
        } else if sgmtControl.selectedSegmentIndex == 1 { //Loan
            let type = "Loan"
            if currentLoan == nil {
                let context = appDelegate.persistentContainer.viewContext
                currentLoan = Loan(context: context)
            }
            appDelegate.saveContext()
            changeMode(self)
            alertObjectSaved(Type: type)

        } else { //Checking
            let type = "Checking"
            if currentChecking == nil {
                let context = appDelegate.persistentContainer.viewContext
                currentChecking = Checking(context: context)
            }
            appDelegate.saveContext()
            changeMode(self)
            alertObjectSaved(Type: type)

        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        changeMode(self)
    }
    
    func alertObjectSaved(Type: String) {
        let alertController  = UIAlertController(title: "Save", message: "\(Type) " + "Saved", preferredStyle: .alert)
        let actionOkay = UIAlertAction(title: "Okay" , style: .default, handler: nil)
        alertController.addAction(actionOkay)
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
