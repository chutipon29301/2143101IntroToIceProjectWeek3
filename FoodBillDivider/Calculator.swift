//
//  Calculator.swift
//  FoodBillDivider
//
//  Created by admin on 9/5/2560 BE.
//  Copyright © 2560 MonkeyIT. All rights reserved.
//

import UIKit
import RealmSwift

class CalculatorTableViewController: UITableViewController {
    
    var rowCount = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row != rowCount - 1) ? 44.0: 130.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader") as! HeaderTableViewCell
            return cell
        case 1...rowCount - 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicCell") as! InputTableViewCell
            return cell
        case rowCount - 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteTableViewCell
            return cell
        case rowCount - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell") as! ActionTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader") as! HeaderTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !(indexPath.row == 0 || indexPath.row == rowCount - 1 || indexPath.row == rowCount - 2)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            rowCount -= 1
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addRow(_ sender: UIBarButtonItem) {
        rowCount += 1
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: rowCount - 3, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    @IBAction func moneyTextFieldDidChange(_ sender: UITextField) {
        calculate()
    }
    
    @IBAction func shareTextFieldDidChange(_ sender: UITextField) {
        if sender.text == "" {
            sender.text = "1"
        }
        calculate()
    }
    
    @IBAction func shareTextFieldBeginChange(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func discountTextFieldDidChange(_ sender: UITextField) {
        calculate()
    }
    
    func calculate() {
        let resultCell = tableView.cellForRow(at: IndexPath(row: rowCount - 1, section: 0)) as! ActionTableViewCell
        var priceSum = 0.0
        var personSum = 0.0
        for i in 1..<rowCount - 2 {
            let detailCell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! InputTableViewCell
            if let price = Double(detailCell.moneyTextField.text!){
                priceSum += price
            }
            if let person = Double(detailCell.shareTextField.text!){
                personSum += person
            }
        }
        let vat = (resultCell.vatSwitch.isOn) ? 0.07 : 0.0
        let serviceCharge = (resultCell.serviceChargeSwitch.isOn) ? 0.1 : 0.0
        let vatSum = priceSum * vat
        let serviceChageSum = priceSum * serviceCharge
        var discountSum: Double
        if let discount = Double(resultCell.discountLabel.text!) {
            discountSum = priceSum * (discount/100)
        }else{
            discountSum = 0.0
        }
        let totalValue = (priceSum + vatSum + serviceChageSum - discountSum) / personSum
        resultCell.totalValue.text = String(totalValue)
        
        self.tableView.reloadData()
    }
    
    @IBAction func save(_ sender: Any) {
        let resultCell = tableView.cellForRow(at: IndexPath(row: rowCount - 1, section: 0)) as! ActionTableViewCell
        let record = Record()
        var priceSum = 0.0
        var personSum = 0.0
        for i in 1..<rowCount - 2 {
            let detailCell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! InputTableViewCell
            let line = Line()
            if let price = Int(detailCell.moneyTextField.text!){
                priceSum += Double(price)
                line.cost = price
            }
            if let person = Int(detailCell.shareTextField.text!){
                personSum += Double(person)
                line.share = person
            }
            record.lists.append(line)
        }
        let vat = (resultCell.vatSwitch.isOn) ? 0.07 : 0.0
        let serviceCharge = (resultCell.serviceChargeSwitch.isOn) ? 0.1 : 0.0
        let vatSum = priceSum * vat
        let serviceChageSum = priceSum * serviceCharge
        var discountSum: Double
        if let discount = Int(resultCell.discountLabel.text!) {
            discountSum = priceSum * (Double(discount)/100)
            record.discount = discount
        }else{
            discountSum = 0.0
            record.discount = 0
        }
        record.sum = (priceSum + vatSum + serviceChageSum - discountSum) / personSum
        let noteCell = tableView.cellForRow(at: IndexPath(row: rowCount - 2, section: 0)) as! NoteTableViewCell
        
        if let text = noteCell.noteTextField.text {
            record.note = text
        }
        
        record.isVatCalculate = resultCell.vatSwitch.isOn
        record.isServiceChangeCalculate = resultCell.serviceChargeSwitch.isOn
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
    }
    
    @IBAction func refreshPage(_ sender: Any) {
        calculate()
    }
    
}

class HeaderTableViewCell: UITableViewCell {
    
}

class InputTableViewCell: UITableViewCell {
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var shareTextField: UITextField!
}

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var noteTextField: UITextField!
    
}

class ActionTableViewCell: UITableViewCell {
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var vatSwitch: UISwitch!
    @IBOutlet weak var serviceChargeSwitch: UISwitch!
    @IBOutlet weak var discountLabel: UITextField!
}
