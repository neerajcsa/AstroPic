//
//  AstroPicViewModel.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 29/01/22.
//

import Foundation

protocol AstroPicViewModelDelegate {
    var title : String { get set }
    var url : String { get set }
    var explanation : String { get set }
}

struct AstroPicViewModel : AstroPicViewModelDelegate {
    var astroPicData : AstroPicData
    
    var title: String
    
    var url: String
    
    var explanation: String
    
    //MARK: Initialization
    
    init(astroPicData : AstroPicData) {
        self.astroPicData = astroPicData
        
        self.title = astroPicData.title
        self.url = astroPicData.url
        self.explanation = astroPicData.explanation
    }
}
