//
//  ViewController.swift
//  Bitcoin Price App
//
//  Created by laptop on 2022-11-04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var euroLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDefaultPrices()
        getPrice()
    }
    
    func getDefaultPrices() {
        let usdPrice = UserDefaults.standard.double(forKey: "USD")
        if usdPrice != 0.0 {
            self.usdLabel.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD") + "~"
        }
        
        let euroPrice = UserDefaults.standard.double(forKey: "EUR")
        if euroPrice != 0.0 {
            self.euroLabel.text = self.doubleToMoneyString(price: euroPrice, currencyCode: "EUR") + "~"
        }
        
        let jpyPrice = UserDefaults.standard.double(forKey: "JPY")
        if jpyPrice != 0.0 {
            self.jpyLabel.text = self.doubleToMoneyString(price: jpyPrice, currencyCode: "JPY") + "~"
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        getPrice()
    }
    
    func getPrice(){
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR&51c19b322954ce0b27566c78ad0235e093fd2cb150762fbde2a9965c61b32491") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Double] {
                        
                        DispatchQueue.main.async {
                            if let usdPrice = json["USD"] {
                                self.usdLabel.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD")
                                UserDefaults.standard.set(usdPrice, forKey: "USD")
                            }
                            if let euroPrice = json["EUR"] {
                                self.euroLabel.text = self.doubleToMoneyString(price: euroPrice, currencyCode: "EUR")
                                UserDefaults.standard.set(euroPrice, forKey: "EUR")
                            }
                            if let jpyPrice = json["JPY"] {
                                self.jpyLabel.text = self.doubleToMoneyString(price: jpyPrice, currencyCode: "JPY")
                                UserDefaults.standard.set(jpyPrice, forKey: "JPY")
                            }
                            UserDefaults.standard.synchronize()
                        }
                        
                    }
                } else {
                    print("Something went wrong!")
                }
            }.resume()
        }
    }
    
    func doubleToMoneyString(price: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        let priceString = formatter.string(from: NSNumber(value: price))
        if priceString == nil {
            return "ERROR"
        } else {
            return priceString!
        }
    }

}

