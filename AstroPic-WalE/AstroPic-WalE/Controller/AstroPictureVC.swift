//
//  AstroPictureVC.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 29/01/22.
//

import UIKit

class AstroPictureVC: UIViewController, AstroPicErrorDelegate {
    
    let astroImageView = APAstroImageView(frame: .zero)
    let astroTitle = APTitleLabel(alignment: .center, fontSize: 16)
    let astroDescription = APDescriptionLabel(alignment: .left, fontSize: 14)
    
    private var astroPicViewModel  : AstroPicViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureAstroImageView()
        configureAstroTitleLabel()
        configureAstroDescriptionLabel()
        callToViewModelForUpdateUI()
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
            astroTitle.heightAnchor.constraint(equalToConstant: 20)
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
    
    private func callToViewModelForUpdateUI() {
        //Show activity indicator
        showLoadingView()
        
        self.astroPicViewModel = AstroPicViewModel()
        self.astroPicViewModel.delegate = self
        
        self.astroPicViewModel.bindAstroPicViewModelToController = { [weak self] in
            guard let self = self else {
                return
            }
            
            let group = DispatchGroup()
            DispatchQueue.global(qos: .background).async {
                NetworkManager.shared.downloadImage(from: self.astroPicViewModel.astroPicData.url) { result in
                    group.leave()
                    switch result {
                    
                    case .success(let image):
                        //Update UI on main thread
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.updateImageView(with: image)
                            self.updateLabels()
                        }
                    case .failure(let error):
                        //display error
                        DispatchQueue.main.async {
                            let title = "Error"
                            let message = "There was an error while fetching Image.\n \(error.localizedDescription)"
                            self.displayErrorAlert(title: title, message: message)
                        }
                    }
                }
            }
            
            group.enter()
            
            group.notify(queue: .main) {
                self.dismissLoadingView()
            }
                    
        }
    }
    
    private func updateImageView(with image : UIImage) {
        self.astroImageView.isHidden = false
        self.astroImageView.image = image
    }
    
    private func updateLabels() {
        self.astroTitle.text = self.astroPicViewModel.astroPicData.title
        self.astroDescription.text = self.astroPicViewModel.astroPicData.explanation
    }
    
    
    func displayError(error: APError) {
        //display error
        DispatchQueue.main.async {
            let title = "Network Error"
            let message = "There was an error while fetching Image.\n \(error.localizedDescription)"
            self.dismissLoadingView()
            self.displayErrorAlert(title: title, message: message)
        }
    }
}

