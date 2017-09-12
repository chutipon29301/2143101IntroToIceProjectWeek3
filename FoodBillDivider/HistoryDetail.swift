//
//  HistoryDetail.swift
//  FoodBillDivider
//
//  Created by admin on 9/12/2560 BE.
//  Copyright © 2560 MonkeyIT. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UITableViewController {
    var record: Record!
    @IBOutlet weak var label: UINavigationItem!
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == record.lists.count - 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "note") as! NoteTableViewCell
            return cell
        }else if(indexPath.row == record.lists.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detail") as! DetailTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "price") as! PriceTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return record.lists.count + 2
    }
}

class PriceTableViewCell: UITableViewCell {
    @IBOutlet weak var pricaLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    
}

class NoteHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var noteLabel: UILabel!
    
}

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var pricePerPerson: UILabel!
    @IBOutlet weak var serviceCharge: UILabel!
    @IBOutlet weak var vat: UILabel!
    @IBOutlet weak var discount: UILabel!
}
