//
//  Currencies.swift
//  CurrencyConverter
//
//  Created by David A Cantú Delgado on 11/19/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit

class Currencies: NSObject {
    var symbol : String
    var currencyName : String
    
    init(symbol : String, currencyName : String) {
        self.symbol = symbol
        self.currencyName = currencyName
    }

}
