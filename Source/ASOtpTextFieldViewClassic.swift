//
//  ASOtpTextFieldClassic.swift
//  superapp
//
//  Created by Amit on 7/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public class ASOtpTextFieldViewClassic: ASOtpTextFieldView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public init(_ number: Int) {
        super.init(frame: CGRect.zero)
        self.number = number
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
        container?.clipsToBounds = true
        container?.layer.rasterizationScale = UIScreen.main.scale
        container?.layer.shouldRasterize = true
        container?.backgroundColor = .clear
        setBordeColor(UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0))
        setBordeWidth(1.0)
        
        addField()
    }
}
