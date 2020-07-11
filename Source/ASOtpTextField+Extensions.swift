//
//  ASOtpTextField+Extensions.swift
//  superapp
//
//  Created by Amit on 8/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

extension ASOtpTextField {
    public func setupConstraints() {
        container?.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            container?.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
            container?.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
            container?.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
            container?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
            
            textField?.translatesAutoresizingMaskIntoConstraints = false
            textField?.topAnchor.constraint(equalTo: container.unsafelyUnwrapped.topAnchor, constant: padding).isActive = true
            textField?.leftAnchor.constraint(equalTo: container.unsafelyUnwrapped.leftAnchor, constant: padding).isActive = true
            textField?.rightAnchor.constraint(equalTo: container.unsafelyUnwrapped.rightAnchor, constant: -padding).isActive = true
            textField?.bottomAnchor.constraint(equalTo: container.unsafelyUnwrapped.bottomAnchor, constant: -padding).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }
}
