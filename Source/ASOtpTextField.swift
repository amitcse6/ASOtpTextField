//
//  ASOtpFieldBase.swift
//  superapp
//
//  Created by Amit on 8/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public protocol ASOtpTextFieldDelegate {
    func textFieldDidDelete(_ textField: ASOtpField)
}

public class ASOtpTextField: UIView {
    public var customDelegate: ASOtpTextFieldDelegate?
    public var index = 0
    public var container: UIView?
    public var textField: ASOtpField?
    public var padding: CGFloat = 2
    public var iscCornerRadius = true
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if iscCornerRadius {
            let cornerRadius = (container?.bounds.size.height ?? 0 - padding*2) * 0.5
            container?.layer.cornerRadius = cornerRadius
        }
    }
}

extension ASOtpTextField: ASOtpFieldDelegate {
    public func textFieldDidDelete(_ textField: ASOtpField) {
        customDelegate?.textFieldDidDelete(textField)
    }
}

extension ASOtpTextField {
    func getText() -> String {
        return textField?.text ?? ""
    }
    
    @discardableResult
    func setBordeColor(_ borderColor: UIColor) -> ASOtpTextField {
        container?.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    func setBordeWidth(_ borderWidth: CGFloat) -> ASOtpTextField {
        container?.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func setBackgroundColor(_ backgroundColor: UIColor) -> ASOtpTextField {
        self.backgroundColor = backgroundColor
        container?.backgroundColor = backgroundColor
        return self
    }
}
