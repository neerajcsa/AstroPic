//
//  APAstroImageView.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 30/01/22.
//

import UIKit

class APAstroImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        contentMode = .scaleAspectFit
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
}

