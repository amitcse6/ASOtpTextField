//
//  ASOtpTextField.swift
//  superapp
//
//  Created by Amit on 7/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

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
    func getTextArray() -> [String] {
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
    func setBecomeFirstResponder(_ index: Int) -> ASOtpTextFieldView {
        goNextField(selectedTextField: nil)
        return self
    }
    
    @discardableResult
    func setBordeColor(_ borderColor: UIColor) -> ASOtpTextFieldView {
        container?.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    func setBordeWidth(_ borderWidth: CGFloat) -> ASOtpTextFieldView {
        container?.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func setBackgroundColor(_ backgroundColor: UIColor) -> ASOtpTextFieldView {
        self.backgroundColor = backgroundColor
        container?.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func setFieldBackgroundColor(_ backgroundColor: UIColor) -> ASOtpTextFieldView {
        textFields?.forEach({ $0.setBackgroundColor(backgroundColor) })
        return self
    }
}
