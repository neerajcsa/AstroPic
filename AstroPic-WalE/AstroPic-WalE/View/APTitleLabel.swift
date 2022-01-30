//
//  APTitleLabel.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 29/01/22.
//

import UIKit

class APTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize : CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }

    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
