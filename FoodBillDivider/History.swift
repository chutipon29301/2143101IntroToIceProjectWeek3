//
//  History.swift
//  FoodBillDivider
//
//  Created by admin on 9/5/2560 BE.
//  Copyright © 2560 MonkeyIT. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryTableViewController: UITableViewController {
    
    var nextTitle = ""
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let resultArray = Array(realm.objects(Record.self))
        return resultArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()
        let resultArray = Array(realm.objects(Record.self))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm:ss"
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryTableViewCell
        cell.dateLabel.text = formatter.string(from: resultArray[indexPath.row].date)
        nextTitle = formatter.string(from: resultArray[indexPath.row].date)
        cell.sumLabel.text = String(resultArray[indexPath.row].sum)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let resultArray = Array(realm.objects(Record.self))
        performSegue(withIdentifier: "showHistoryDetail", sender: resultArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showHistoryDetail":
                let destination = segue.destination as! HistoryDetailViewController
                if let record = sender as? Record {
                    destination.record = record
                    destination.label.title = nextTitle
                }
                break
            default:
                break
            }
        }
    }
}

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
}
