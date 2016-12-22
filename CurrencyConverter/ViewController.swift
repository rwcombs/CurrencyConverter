//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Wesley Combs on 12/20/16.
//  Copyright © 2016 Wesley Combs. All rights reserved.
//
//  Built using the tutorial by Sebastian Henry aka The Swift Guy
//  https://www.youtube.com/watch?v=A407_GYasN8
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0;
    
    // Objects
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
    // Creating pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    
    
    // Button
    @IBAction func action(_ sender: Any)
    {
        if input.text != nil
        {
        output.text = String(Double(input.text!)! * activeCurrency)
        }
        
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Getting Data
        let url = URL(string:"http://api.fixer.io/latest")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil
            {
                print("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        //print(myJson)
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            //print (rates)
                            
                            for (key, value) in rates
                            {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                            print (self.myCurrency)
                            print (self.myValues)
                        }
                        
                    }
                    catch
                    {
                        
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        task.resume()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

