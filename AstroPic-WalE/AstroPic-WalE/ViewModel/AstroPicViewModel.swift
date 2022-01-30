//
//  AstroPicViewModel.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 29/01/22.
//

import Foundation

protocol AstroPicErrorDelegate : AnyObject {
    func displayError(error : APError)
}

class AstroPicViewModel : NSObject {
    
    private(set) var astroPicData : AstroPicData! {
        didSet {
            self.bindAstroPicViewModelToController()
        }
    }
    
    weak var delegate : AstroPicErrorDelegate?
    
    var bindAstroPicViewModelToController : (() -> ()) = { }
    
    //MARK: Initialization
    
    override init() {
        super.init()
        
        let cacheKey = Utility.shared.getCurrentDate(date: Date())
        let dicAstroPic = UserDefaults.standard.value(forKey: cacheKey) as? [String:String]  ?? [:]
        
        DispatchQueue.global(qos: .background).async {
            if !dicAstroPic.keys.isEmpty {
                self.setAstroPicData(dicAstroPic : dicAstroPic)
            } else {
                self.callServiceToGetAstroPicData()
            }
        }
    }
    
    private func setAstroPicData(dicAstroPic : [String : String]) {
        let title = dicAstroPic["title"] ?? ""
        let explanation = dicAstroPic["explanation"] ?? ""
        let url = dicAstroPic["url"] ?? ""
        
        let astroPicData = AstroPicData(explanation: explanation, title: title, url: url)
        self.astroPicData = astroPicData
    }
    
    private func callServiceToGetAstroPicData() {
        NetworkManager.shared.getAstroPicDetails(apiKey: Endpoints.apiKey) { result in
            
            switch result {
            case .success(let astroPicData):
                self.astroPicData = astroPicData
                
                //Save to user defaults
                self.saveAstroPicData(astroPicData: astroPicData)
            case .failure(let error):
                self.delegate?.displayError(error: error)
            }
        }
    }
    
    private func saveAstroPicData(astroPicData : AstroPicData) {
        let cacheKey = Utility.shared.getCurrentDate(date: Date())
        
        let defaults = UserDefaults.standard
        let dicAstroPic = ["title" : astroPicData.title, "explanation" : astroPicData.explanation, "url" : astroPicData.url]
        
        //set title and explanation
        defaults.set(dicAstroPic, forKey: cacheKey)
    }
}
