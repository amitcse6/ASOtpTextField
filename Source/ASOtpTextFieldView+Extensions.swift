//
//  ASOtpTextFieldView+Extensions.swift
//  superapp
//
//  Created by Amit on 8/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

extension ASOtpTextFieldView {
    public func setupConstraints() {
        container?.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            container?.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
            container?.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
            container?.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
            container?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
            
            textFields?.forEach({ textField in
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.topAnchor.constraint(equalTo: container.unsafelyUnwrapped.topAnchor).isActive = true
                if textField.index == 0 {
                    textField.leftAnchor.constraint(equalTo: container.unsafelyUnwrapped.leftAnchor).isActive = true
                }else {
                    textField.leftAnchor.constraint(equalTo: textFields.unsafelyUnwrapped[textField.index-1].rightAnchor).isActive = true
                }
                if textField.index == textFields.unsafelyUnwrapped.count - 1 {
                    textField.rightAnchor.constraint(equalTo: container.unsafelyUnwrapped.rightAnchor).isActive = true
                }
                textField.bottomAnchor.constraint(equalTo: container.unsafelyUnwrapped.bottomAnchor).isActive = true
                textField.widthAnchor.constraint(equalTo: textFields.unsafelyUnwrapped[0].widthAnchor).isActive = true
            })
        } else {
            // Fallback on earlier versions
        }   
    }
}
