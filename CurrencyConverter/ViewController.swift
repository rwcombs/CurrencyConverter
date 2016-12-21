//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Wesley Combs on 12/20/16.
//  Copyright © 2016 Wesley Combs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
                        
                        print(myJson)
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
        task.resume()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

