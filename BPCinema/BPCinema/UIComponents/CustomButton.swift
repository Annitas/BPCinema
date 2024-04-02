//
//  CustomButton.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import UIKit

class CustomButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = .custom
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)        
        layer.cornerRadius = 9
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
