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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader")!
        return cell
    }
}

class HeaderTableViewCell: UITableViewCell {
    
}
