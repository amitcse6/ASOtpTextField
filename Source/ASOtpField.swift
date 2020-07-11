//
//  ASOtpField.swift
//  superapp
//
//  Created by Amit on 7/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public protocol ASOtpFieldDelegate {
    func textFieldDidDelete(_ textField: ASOtpField)
}

public class ASOtpField: UITextField {
    public var customDelegate: ASOtpFieldDelegate?
    public var index = 0
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init(_ customDelegate: ASOtpFieldDelegate?, _ index: Int) {
        super.init(frame: CGRect.zero)
        self.index = index
        self.customDelegate = customDelegate
    }
    
    public override func deleteBackward() {
        super.deleteBackward()
        customDelegate?.textFieldDidDelete(self)
    }
}
