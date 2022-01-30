//
//  NetworkManager.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 30/01/22.
//

import Foundation

struct Endpoints {
    fileprivate static let baseApi = "https://api.nasa.gov/planetary/apod"
    fileprivate static let apiKey = "wIFZuMz6u65ss3deJ31j3gLppYa8WKveRKVJLoIu"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    
}
