//
//  ASOtpTextField.swift
//  superapp
//
//  Created by Amit on 7/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public class ASOtpTextFieldClassic: ASOtpTextField {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public init(_ index: Int) {
        super.init(frame: CGRect.zero)
        self.index = index
        setup()
    }
    
    public func setup() {
        setupUIElements()
        setupConstraints()
    }
    
    public func setupUIElements() {
        backgroundColor = .clear
        
        container = UIView()
        addSubview(self.container.unsafelyUnwrapped)
        container?.layer.rasterizationScale = UIScreen.main.scale
        container?.layer.shouldRasterize = true
        container?.backgroundColor = .clear
        setBordeColor(UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0))
        setBordeWidth(1.0)
        
        textField = ASOtpField(self, index)
        container?.addSubview(textField.unsafelyUnwrapped)
        textField?.backgroundColor = .clear
    }
}


