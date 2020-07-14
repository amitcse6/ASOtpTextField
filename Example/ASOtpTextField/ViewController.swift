//
//  ViewController.swift
//  ASOtpTextField
//
//  Created by amitpstu1@gmail.com on 07/11/2020.
//  Copyright (c) 2020 amitpstu1@gmail.com. All rights reserved.
//

import UIKit
import ASOtpTextField

class ViewController: UIViewController {
    
    @IBOutlet weak var otpField: ASOtpTextFieldViewClassic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpField
            .setField(6)
            .setInputBoxStyle(.box)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitEventHandler(_ sender: Any) {
        let otpArray = otpField?.getTextArray()
        let otp = otpArray?.joined(separator: "")
        print("otp: \(otp ?? "")")
    }
}

