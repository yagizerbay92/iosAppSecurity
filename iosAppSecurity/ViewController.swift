//
//  ViewController.swift
//  iosAppSecurity
//
//  Created by Erbay, Yagiz on 23.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //save data example
        let data = KeyChain.shared.stringToNSDATA(string: "abc")
        let status = KeyChain.shared.save(key: "TestString", data: data)
        print("status = \(status)")
        
        
        //get data example
        if let receivedData = KeyChain.shared.load(key: "TestString") {
            let result = KeyChain.shared.NSDATAtoString(data: receivedData)
            print("Result = \(result)")
        }
    }
}

