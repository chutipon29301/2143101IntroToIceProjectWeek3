//
//  History.swift
//  FoodBillDivider
//
//  Created by admin on 9/5/2560 BE.
//  Copyright © 2560 MonkeyIT. All rights reserved.
//

import UIKit
//import RealmSwift

class HistoryTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryTableViewCell
        cell.dateLabel.text = "Hello World"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showHistoryDetail", sender: nil)
    }
}

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
}
