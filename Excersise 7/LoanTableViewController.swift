//
//  ContactsTableViewController.swift
//  My Contact List
//
//  Created by Voss, Garrett on 5/1/18.
//  Copyright © 2018 Voss, Garrett. All rights reserved.
//

import UIKit
import CoreData

class LoanTableViewController: UITableViewController {
    // let contacts = ["Jim","John","Dana","Rosie","Justin","Jeremy","Sarah","Matt","Joe","Donald","Jeff"]
    var loans:[NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadDataFromDatabase()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDataFromDatabase()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromDatabase() {

        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Loan")
        
        do {
            loans = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoanCell", for: indexPath)
        
        // Configure the cell...
        let loan = loans[indexPath.row] as? Loan
        cell.textLabel?.text = loan!.accountNumber
        cell.detailTextLabel?.text = loan?.currentBalance
        cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton

        return cell
    }
    
   /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLoan = loans[indexPath.row] as? Loan
        let accountnumber = selectedLoan!.accountNumber!
        let actionHandler = { (action:UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "EditLoan", sender: tableView.cellForRow(at: indexPath))
        }
        
        let alertController = UIAlertController(title: "Loan Selected", message: "Selected row: \(indexPath.row) (\(accountnumber))", preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let actionDetails = UIAlertAction(title: "Show Details", style: .default, handler: actionHandler)
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionDetails)
        present (alertController, animated: true, completion: nil)
        
    }
 */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let loan = loans[indexPath.row] as? Loan
            let context = appDelegate.persistentContainer.viewContext
            context.delete(loan!)
            do {
                try context.save()
            } catch {
                fatalError("Error saving context: \(error)")
            }
            loadDataFromDatabase()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditLoan" {
            let loanController = segue.destination as? ViewController
            let selectedRow = self.tableView.indexPath(for: sender as! UITableViewCell)?.row
            let selectedloan = loans[selectedRow!] as? Loan
            loanController?.currentLoan = selectedloan!
            
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
}
