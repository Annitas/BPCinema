//
//  CustomTextField.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import UIKit

class CustomTextField: UITextField {

    init(placeholderText: String, isPassword: Bool = false) {
        super.init(frame: .zero)
        placeholder = placeholderText
        font = UIFont.systemFont(ofSize: 15)
        borderStyle = UITextField.BorderStyle.roundedRect
        autocorrectionType = UITextAutocorrectionType.no
        autocapitalizationType = .none
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        keyboardType = UIKeyboardType.default
        returnKeyType = UIReturnKeyType.done
        clearButtonMode = UITextField.ViewMode.whileEditing
        translatesAutoresizingMaskIntoConstraints = false
        
        if isPassword {
            isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
