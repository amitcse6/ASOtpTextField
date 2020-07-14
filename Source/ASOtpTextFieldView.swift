//
//  ASOtpTextField.swift
//  superapp
//
//  Created by Amit on 7/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public enum ASOInputBoxStyle {
    case box
    case oval
}

public class ASOtpTextFieldView: UIView {
    public var container: UIView?
    public var textFields: [ASOtpTextField]?
    public var number = 0
    public var iscCornerRadius = true
    public var padding: CGFloat = 5
    public var maxLength = 1
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if iscCornerRadius { 
            let cornerRadius = (container?.bounds.size.height ?? 0 - padding*2) * 0.5
            container?.layer.cornerRadius = cornerRadius
        }
    }
    
    
    func goNextField(selectedTextField: ASOtpField?) {
        if let selectedTextField = selectedTextField {
            if let textFields = textFields {
                textFields.forEach({ (textField) in
                    if selectedTextField.index == textField.index, selectedTextField.index < textFields.count - 1 {
                        DispatchQueue.main.async {
                            selectedTextField.resignFirstResponder()
                            textFields[selectedTextField.index+1].textField?.becomeFirstResponder()
                        }
                        return
                    }
                })
            }
        }else {
            textFields?.first?.textField?.becomeFirstResponder()
        }
    }
    
    func goPreviousField(selectedTextField: ASOtpField) {
        if let textFields = textFields {
            textFields.forEach({ (textField) in
                if selectedTextField.index == textField.index, selectedTextField.index > 0 {
                    DispatchQueue.main.async {
                        selectedTextField.resignFirstResponder()
                        textFields[selectedTextField.index-1].textField?.becomeFirstResponder()
                    }
                    return
                }
            })
        }
    }
    
    func addField() {
        textFields = (0..<number).map { index in
            let textField = ASOtpTextFieldClassic(index)
            textField.backgroundColor = .clear
            textField.textField?.textAlignment = .center
            textField.textField?.delegate = self
            textField.customDelegate = self
            textField.textField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
            return textField
        }
        textFields?.forEach({ textField in container?.addSubview(textField) })
    }
}


extension ASOtpTextFieldView: ASOtpTextFieldDelegate {
    public func textFieldDidDelete(_ textField: ASOtpField) {
        let updatedText = textField.text ?? ""
        if updatedText.count == 0 {
            goPreviousField(selectedTextField: textField)
        }
    }
}

extension ASOtpTextFieldView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.count > 0 {
                goNextField(selectedTextField: textField as? ASOtpField)
                textField.text = string
                return false
            }
            return updatedText.count <= maxLength
        }
        return true
    }
    
    @objc public func textFieldDidChange(textField: UITextField) {
        let updatedText = textField.text ?? ""
        if updatedText.count > 0 {
            goNextField(selectedTextField: textField as? ASOtpField)
        }
    }
}

extension ASOtpTextFieldView {
    public func getTextArray() -> [String] {
        return textFields?.map({ $0.getText() }) ?? []
    }
    
    @discardableResult
    public func setField(_ number: Int) -> ASOtpTextFieldView {
        self.number = number
        addField()
        setupConstraints()
        return self
    }
    
    @discardableResult
    public func setBecomeFirstResponder(_ index: Int) -> ASOtpTextFieldView {
        goNextField(selectedTextField: nil)
        return self
    }
    
    @discardableResult
    public func setFieldBackgroundColor(_ backgroundColor: UIColor) -> ASOtpTextFieldView {
        textFields?.forEach({ $0.setBackgroundColor(backgroundColor) })
        return self
    }
}

extension ASOtpTextFieldView {
    @discardableResult
    public func setBordeColor(_ borderColor: UIColor) -> ASOtpTextFieldView {
        container?.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    public func setBordeWidth(_ borderWidth: CGFloat) -> ASOtpTextFieldView {
        container?.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(_ backgroundColor: UIColor) -> ASOtpTextFieldView {
        self.backgroundColor = backgroundColor
        container?.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ cornerRadius: CGFloat) -> ASOtpTextFieldView {
        container?.layer.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    public func setBorderColor(_ borderColor:UIColor) -> ASOtpTextFieldView {
        container?.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    public func setDefaultShadow() -> ASOtpTextFieldView {
        if #available(iOS 9.0, *) {
            setShadow(UIColor(asoValue: "#ffffff", alpha: 1.0), UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0), UIColor(asoValue: "#AAAAAA", alpha: 1.0), 5, scale: true)
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    public func setShadow(_ backgroundColor: UIColor, _ borderColor: UIColor, _ shadowColor: UIColor, _ shadowRadius: CGFloat, scale: Bool) -> ASOtpTextFieldView {
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
        return self
    }
    
    @discardableResult
    public func setInputBoxStyle(_ inputBoxStyle: ASOInputBoxStyle) -> ASOtpTextFieldView {
        switch inputBoxStyle {
        case .box:
            textFields?.forEach({ $0.setInputStyleBox(textFields?.count ?? 0) }) 
        case .oval:
            textFields?.forEach({ $0.setInputStyleOval(textFields?.count ?? 0) })
        }
        return self
    }
}

@available(iOS 9.0, *)
extension UIColor {
    convenience init(asoRed: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(asoRed >= 0 && asoRed <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(asoRed) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(asoValue: Int, alpha: CGFloat) {
        self.init(red: CGFloat((asoValue >> 16) & 0xFF), green: CGFloat((asoValue >> 8) & 0xFF), blue: CGFloat(asoValue & 0xFF), alpha: alpha)
    }
    
    convenience init(asoValue: String, alpha: CGFloat = 1.0) {
        let hexString: String = asoValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func asoHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
