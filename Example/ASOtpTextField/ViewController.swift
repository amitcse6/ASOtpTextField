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
        // Do any additional setup after loading the view, typically from a nib.
        
        otpField.backgroundColor = .clear
        otpField.setField(5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

