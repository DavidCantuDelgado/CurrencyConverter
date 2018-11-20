//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by David A Cantú Delgado on 11/19/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit
import ChameleonFramework
import Alamofire
import SVProgressHUD
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var fromCurrencyPickerView: UIPickerView!
    @IBOutlet weak var toCurrencyPickerView: UIPickerView!
    
    @IBOutlet weak var tfFromAmount: UITextField!
    @IBOutlet weak var tfToAmount: UITextField!
    
    //Global variables
    var currencies = [Currencies]()
    var baseURL : String = "http://data.fixer.io/api/latest?access_key="
    var finalURL : String = " "
    var key : String = "3781356276a8798f7c577f21c96aaaf8"
    var symbolsURL : String = "http://data.fixer.io/api/symbols?access_key="
    var fromCurrency : String = "USD"
    var toCurrency : String = "MXN"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        var currency = Currencies(symbol: "MXN", currencyName: "Pesos")
//        currencies.append(currency)
//        currency = Currencies(symbol: "USD", currencyName: "US Dollars")
//        currencies.append(currency)

        // Do any additional setup after loading the view, typically from a nib.
        
        
        // URL's
        symbolsURL = symbolsURL + key
        LoadSymbols()
        //print(self.currencies[0].symbol)
        fromCurrencyPickerView.delegate = self
        fromCurrencyPickerView.dataSource = self
        toCurrencyPickerView.delegate = self
        toCurrencyPickerView.dataSource = self
        
        
    }
    
    //TODO: Functions to obtain symbols
    
    func LoadSymbols() {
        Alamofire.request(symbolsURL, method: .get)
            .responseJSON { response in
                print(self.symbolsURL)
                if response.result.isSuccess {
                    
                    print("Sucess! Got the symbols data")
                    let symbolsJSON : JSON = JSON(response.result.value!)
                    //print(symbolsJSON)
                    let currenciesJSON = symbolsJSON["symbols"].dictionaryValue
                    for (key,value) in currenciesJSON {
                        let currency = Currencies(symbol: key, currencyName: value.stringValue)
                        self.currencies.append(currency)
                        //print(currency.symbol, currency.currencyName)
                    }
                    //print(self.currencies.count)
                    self.currencies.sort(by: {$0.symbol < $1.symbol})
                    self.fromCurrencyPickerView.reloadAllComponents()
                    self.toCurrencyPickerView.reloadAllComponents()
                } else {
                    print("API unavailable")
                }
        }
    }

    //TODO: Button Pressed
    
    @IBAction func convertAmount(_ sender: UIButton) {
        if let amount = Double(tfFromAmount.text!) {
            finalURL = "\(baseURL)\(key)&symbols=\(fromCurrency),\(toCurrency)"
            print(finalURL)
            Alamofire.request(finalURL, method: .get)
                .responseJSON { response in
                    print(self.finalURL)
                    if response.result.isSuccess {
                        
                        print("Sucess! Got the conversion")
                        let convertJSON : JSON = JSON(response.result.value!)
                        print(convertJSON)
                        let amountJSON = convertJSON["rates"].dictionaryValue
                        print("hola")
                        print(amountJSON)
                        var fromAmount : Double = 0
                        var toAmount : Double = 0
                        for (key,value) in amountJSON {
                            if key == self.fromCurrency {
                                fromAmount = value.double!
                            } else if key == self.toCurrency {
                                toAmount = value.double!
                            }
                        }
                        print(amount,fromAmount,toAmount)
                        let amountConverted = amount / fromAmount * toAmount
                        self.tfToAmount.text = String(format: "%.2f",amountConverted)
                    } else {
                        print("API unavailable")
                    }
            }
        } else {
            let alerta = UIAlertController(title: "Mensaje de error", message: "Teclea un valor a convertir", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
    }
    
//    func calcula() {
//        if let money = Double(tfPesos.text!) {
//            let valorConvertido = money * Double(tiposCambios[monedaSel][monedaTo])
//            let formatter = NumberFormatter()
//            formatter.locale = Locale(identifier: formatoMoneda[monedaTo])
//            formatter.numberStyle = .currency
//            if let formatedValor = formatter.string(from: valorConvertido as NSNumber) {
//                tfResultado.text = "\(formatedValor)"
//            }
//
//        } else {
//            let alerta = UIAlertController(title: "Mensaje de error", message: "Teclea un valor a convertir", preferredStyle: .alert)
//            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            present(alerta, animated: true, completion: nil)
//        }
//    }
    
    //TODO: Place your 4 UIPickerView delegate methods here
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(currencies[row].symbol) - \(currencies[row].currencyName)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            fromCurrency = currencies[row].symbol
        } else {
            toCurrency = currencies[row].symbol
        }
    }

}

