//
//  AstroPictureVC.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 29/01/22.
//

import UIKit

class AstroPictureVC: UIViewController {
    
    let astroImageView = APAstroImageView(frame: .zero)
    let astroTitle = APTitleLabel(alignment: .center, fontSize: 16)
    let astroDescription = APDescriptionLabel(alignment: .center, fontSize: 14)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureAstroImageView()
        configureAstroTitleLabel()
        configureAstroDescriptionLabel()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        self.title = "Home"
    }
    
    private func configureAstroImageView() {
        view.addSubview(astroImageView)
        
        NSLayoutConstraint.activate([
            astroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            astroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            astroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            astroImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func configureAstroTitleLabel() {
        view.addSubview(astroTitle)

        NSLayoutConstraint.activate([
            astroTitle.topAnchor.constraint(equalTo: astroImageView.bottomAnchor, constant: 12),
            astroTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            astroTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            astroTitle.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func configureAstroDescriptionLabel() {
        view.addSubview(astroDescription)
        
        NSLayoutConstraint.activate([
            astroDescription.topAnchor.constraint(equalTo: astroTitle.bottomAnchor, constant: 12),
            astroDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            astroDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            astroDescription.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
}
