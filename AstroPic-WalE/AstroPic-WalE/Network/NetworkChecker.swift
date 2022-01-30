//
//  NetworkChecker.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 30/01/22.
//

import Network
import UIKit

class NetworkChecker {
    
    static let shared = NetworkChecker()
    let monitor = NWPathMonitor()
    
    private var status: NWPath.Status = .requiresConnection
    
    func startMonitoringNetwork() {
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    appDelegate.isNetworkAvailable = true
                }
            } else {
                DispatchQueue.main.async {
                    appDelegate.isNetworkAvailable = false
                }
            }
        }
        
        let queue = DispatchQueue(label: "com.astropic.networkchecker")
        monitor.start(queue: queue)
    }
    
    func stopMonitoringNetwork() {
        monitor.cancel()
    }
}
