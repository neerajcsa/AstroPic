//
//  Utility.swift
//  AstroPic-WalE
//
//  Created by Neeraj Pandey on 30/01/22.
//

import UIKit

struct Utility {
    static let shared = Utility()
    
    private init() { }
    
    func getCurrentDate(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func getDocumentDirectoryPath() -> URL {
        let arrPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = arrPaths[0]
        return docDirectoryPath
      }
    
    func writeToDocumentDirectory(fileURL : URL, data : Data) {
            //Checks if file exists, removes it if so.
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try FileManager.default.removeItem(atPath: fileURL.path)
                    debugPrint("Removed old image.")
                } catch let error {
                    debugPrint("Couldn't remove file at path.", error.localizedDescription)
                }

            }

            do {
                try data.write(to: fileURL)
            } catch let error {
                debugPrint("Error while saving file with error.", error.localizedDescription)
            }
    }
    
    func getImageDataFromDocumentDirectory(fileURL : URL) -> UIImage? {
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }

}
