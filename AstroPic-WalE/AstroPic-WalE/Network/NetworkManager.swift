//
//  NetworkManager.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 30/01/22.
//

import UIKit

struct Endpoints {
    fileprivate static let baseApi = "https://api.nasa.gov/planetary/apod"
    static let apiKey = "wIFZuMz6u65ss3deJ31j3gLppYa8WKveRKVJLoIu"
}

enum APError : String, Error {
    case unableToComplete = "Unable to complete your request. Please chekc your internet connection."
    case invalidURL = "Please check the URL once again."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data received from server was invalid. Please try again."
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    let cache = NSCache<NSString, UIImage>()
    
    func getAstroPicDetails(apiKey : String, completionHandler : @escaping (Result<AstroPicData, APError>) -> Void) {
        let endpoints = Endpoints.baseApi + "?api_key=\(apiKey)"
        
        guard let url = URL(string: endpoints) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let astroPicData = try decoder.decode(AstroPicData.self, from: data)
                completionHandler(.success(astroPicData))
            } catch(let error) {
                debugPrint(error.localizedDescription)
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
