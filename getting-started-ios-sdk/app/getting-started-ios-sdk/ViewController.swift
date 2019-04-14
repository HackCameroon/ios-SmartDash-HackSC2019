//
//  ViewController.swift
//  getting-started-ios-sdk
//
//  Created by Smartcar on 11/19/18.
//  Copyright © 2018 Smartcar. All rights reserved.
//

import Alamofire
import UIKit
import SmartcarAuth
import Firebase

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var vehicleText = ""
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        appDelegate.smartcar = SmartcarAuth(
            clientId: Constants.clientId,
            redirectUri: "sc\(Constants.clientId)://exchange",
            development: true,
            completion: completion
        )
        
        // display a button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.addTarget(self, action: #selector(self.connectPressed(_:)), for: .touchUpInside)
        button.setTitle("Connect your vehicle", for: .normal)
        button.backgroundColor = UIColor.black
		button.center = self.view.center
        self.view.addSubview(button)
        
        // create Firebase database reference
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectPressed(_ sender: UIButton) {
        let smartcar = appDelegate.smartcar!
        smartcar.launchAuthFlow(viewController: self)
    }
    
    func completion(err: Error?, code: String?, state: String?) -> Any {
        // send request to exchange auth code for access token
        Alamofire.request("\(Constants.appServer)/exchange?code=\(code!)", method: .get).responseJSON {_ in
            
            // send request to retrieve the vehicle info
            Alamofire.request("\(Constants.appServer)/vehicle", method: .get).responseJSON { response in
				
				if let result = response.result.value {
					print(result)
                    let JSON = result as! NSDictionary
                    
                    // Adding JSON data to Firebase
                    self.ref.child("locations").child(UUID().uuidString).setValue(JSON)
                    
                    let data = JSON.object(forKey: "data")! as! NSDictionary
					
                    // I am extracting longitdude and latitude from the data json object
					let longitude = data.object(forKey: "longitude")!  //as! String
					let latitude = data.object(forKey: "latitude")!  //as! String

                    let vehicle = "\(latitude),\(longitude)"
				
                    self.vehicleText = vehicle
                    
                    self.performSegue(withIdentifier: "displayVehicleInfo", sender: self)
                }
            }
        }
        
        return ""
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationVC = segue.destination as? InfoViewController {
//            destinationVC.text = self.vehicleText
//        }
//    }

}

