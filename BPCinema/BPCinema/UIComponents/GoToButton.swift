//
//  GoToButton.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import UIKit

class GoToButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
