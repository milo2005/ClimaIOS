//
//  ViewController.swift
//  Clima
//
//  Created by Aplimovil on 11/4/16.
//  Copyright © 2016 Aplimovil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var des: UILabel!
    @IBOutlet var temp: UILabel!
    @IBOutlet var hum: UILabel!
    @IBOutlet var pres: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let client:HttpClient = HttpClient()
        client.get(url: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22popayan%20co%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys", callback: processWeather)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func processWeather(data:Data?){
        
        do{
            let json:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
        
            let query:NSDictionary = json.object(forKey: "query") as! NSDictionary
            let results:NSDictionary = query.object(forKey: "results") as! NSDictionary
            let channel:NSDictionary = results.object(forKey: "channel") as! NSDictionary
            
            let atm:NSDictionary =  channel.object(forKey: "atmosphere") as! NSDictionary
            
            hum.text = atm.object(forKey: "humidity") as! String
            pres.text = atm.object(forKey: "pressure") as! String
            
            let item:NSDictionary =  channel.object(forKey: "item") as! NSDictionary
            let condition:NSDictionary = item.object(forKey: "condition") as! NSDictionary
            
            temp.text = condition.object(forKey: "temp") as! String
            des.text = condition.object(forKey: "text") as! String
            
        }catch{}
        
        
    
    }


}

