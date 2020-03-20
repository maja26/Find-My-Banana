//
//  GenerateCodeViewController.swift
//  findMyBanana
//
//  Created by Maja Drinovac on 17.03.20.
//  Copyright © 2020 Laura Riener. All rights reserved.
//

import UIKit

class GenerateCodeViewController: UIViewController {
    //let createGameUrl = "http:/192.168.177.129:3000/createGame"
    let createGameUrl = "http://127.0.0.1:3000/createGame"
    var token = ""
    
    var model = Model()

    @IBAction func startBtn(_ sender: UIButton) {
        //let queue = DispatchQueue(label: "getToken")
        self.setupPost()
            print("token: \(String(describing: self.token))")
                self.tokenLabel.text = self.token
    }
    @IBOutlet weak var tokenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("hello")
    }
    
    func setupPost(){
        var jsonModel = GameModel(anz: self.model.anz, timeInSec: self.model.timeInSec)
        
        if let url = URL(string: self.createGameUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            //var model = gameModel(anz: 4, timeInSec: 10)
            
            //var jsondata = try? JSONSerialization.data(withJSONObject: model, options: [])
            var jsondata = try? JSONEncoder().encode(jsonModel)

            request.httpBody = jsondata
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("dataString: \(dataString)")
                    self.token = dataString
                    self.saveToken(token:dataString)
                    print("token: \(self.token)")
                }
                if let error = err {
                    print("Error took place \(error)")
                }
            }.resume()
        }else{
            print("URL ist flasch")
        }
    }
    
    func saveToken(token:String){
        print("savetoken: \(token)")
        DispatchQueue.main.async {
            self.tokenLabel.text=token
        }
    }
    
}
