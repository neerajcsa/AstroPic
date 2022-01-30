//
//  AstroPicViewModel.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 29/01/22.
//

import Foundation

class AstroPicViewModel : NSObject {
    
    private(set) var astroPicData : AstroPicData! {
        didSet {
            self.bindAstroPicViewModelToController()
        }
    }
    
    var bindAstroPicViewModelToController : (() -> ()) = { }
    
    //MARK: Initialization
    
    override init() {
        super.init()
        callServiceToGetAstroPicData()
    }
    
    private func callServiceToGetAstroPicData() {
        NetworkManager.shared.getAstroPicDetails(apiKey: Endpoints.apiKey) { result in
            
            switch result {
            case .success(let astroPicData):
                self.astroPicData = astroPicData
            case .failure(let error):
                print(error)
            }
        }
    }
}
