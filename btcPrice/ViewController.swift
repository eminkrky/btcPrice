//
//  ViewController.swift
//  btcPrice
//
//  Created by Emin on 15.10.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button(_ sender: Any) {
        let url = URL(string: "https://api.gemini.com/v2/ticker/btcusd")
        
        let seisson = URLSession.shared
        
        let task = seisson.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            if let price = jsonResponse["open"] as? String{
                                self.label.text = price
                                print(price)
                            }else{
                                print("error")
                            }
                        }
                    }catch{
                        print("Error")
                    }
                    

                }
            }
        }
        task.resume()
        
    }
    
}

