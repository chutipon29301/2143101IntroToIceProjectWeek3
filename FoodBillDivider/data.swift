//
//  data.swift
//  FoodBillDivider
//
//  Created by admin on 9/11/2560 BE.
//  Copyright © 2560 MonkeyIT. All rights reserved.
//

import Foundation
import RealmSwift

class Record: Object {
    dynamic var date = Date()
    let lists = List<Line>()
    dynamic var sum:Double = 0.0
    dynamic var discount = 0
    dynamic var isVatCalculate = false
    dynamic var isServiceChangeCalculate = false
    dynamic var note = ""
}

class Line: Object {
    dynamic var cost = 0
    dynamic var share = 0
}
