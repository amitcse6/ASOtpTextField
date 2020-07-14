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
}


extension ASOtpTextField {
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
    
    @discardableResult
    public func setShadow(_ backgroundColor: UIColor, _ borderColor: UIColor, _ shadowColor: UIColor, _ shadowRadius: CGFloat, scale: Bool, maskedCorners: CACornerMask) -> ASOtpTextField {
        self.container?.layer.shouldRasterize = true
        self.container?.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.container?.backgroundColor = backgroundColor
        self.container?.layer.cornerRadius = shadowRadius
        self.container?.layer.borderColor = borderColor.cgColor
        self.container?.layer.borderWidth = 1
        self.container?.layer.shadowColor = shadowColor.cgColor
        self.container?.layer.shadowOpacity = 1
        self.container?.layer.shadowOffset = CGSize.zero
        self.container?.layer.shadowRadius = shadowRadius
        if #available(iOS 11.0, *) {
            self.container?.layer.maskedCorners = maskedCorners
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func setShadow() -> ASOtpTextField {
        if #available(iOS 9.0, *) {
            setShadow(UIColor(asoValue: "#ffffff", alpha: 1.0), UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0), UIColor(asoValue: "#AAAAAA", alpha: 1.0), 5, scale: true, maskedCorners: [.layerMinXMinYCorner])
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func setInputStyleOval(_ total: Int) -> ASOtpTextField {
        if #available(iOS 11.0, *) {
            let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            switch index {
            case 0:
                self.container?.layer.maskedCorners = maskedCorners
                break
            case total-1:
                self.container?.layer.maskedCorners = maskedCorners
                break
            default:
                self.container?.layer.maskedCorners = maskedCorners
                break
            }
        } else {
            // Fallback on earlier versions
        }
        return self
        
    }
    
    @discardableResult
    public func setInputStyleBox(_ total: Int) -> ASOtpTextField {
        if #available(iOS 11.0, *) {
            switch index {
            case 0:
                self.container?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                break
            case total-1:
                self.container?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                break
            default:
                self.container?.layer.maskedCorners = []
                break
            }
        } else {
            // Fallback on earlier versions
        }
        return self
    }
}
