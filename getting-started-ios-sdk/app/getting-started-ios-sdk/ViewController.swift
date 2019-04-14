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
                    
//                    JSON is a JSON object containing
//                {
//                    age = "2019-04-14T02:04:13.156Z";
//                    data =     {
//                        latitude = "37.87641906738281";
//                        longitude = "-105.5240783691406";
//                    };
//                }
                    
                    
                    //data is a JSON object containing
                    //                {
                    //                    data =     {
                    //                        latitude = "37.87641906738281";
                    //                        longitude = "-105.5240783691406";
                    //                    };
                    //                }
                    
                    
                    // TO READ FROM FIREBASE
//                    ref.child("locations").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
//                        // Get user value
//                        let value = snapshot.value as? NSDictionary
//                        let age = value?["age"] as? String ?? ""
//                        now use age how you like...
//
//                        // ...
//                    }) { (error) in
//                        print(error.localizedDescription)
//                    }
                    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? InfoViewController {
            destinationVC.text = self.vehicleText
        }
    }

}

