//
//  DateAdjuster.swift
//  date-adjuster
//
//  Created by Jean-Étienne on 20/4/17.
//  Copyright © 2017 Jean-Étienne. All rights reserved.
//

import Foundation

struct DateAdjuster {
    
    static func adjustDateOfItems(atPaths paths: [String], withTimeInterval timeInterval: TimeInterval) {
        for path in paths {
            adjustDateOfItem(atPath: path, timeInterval: timeInterval)
        }
    }
 
    private static func creationDateOfItem(atPath path: String) -> Date? {
        let fileManager = FileManager()
        
        guard let attributes = try? fileManager.attributesOfItem(atPath: path) else {
            print("Could not find item at path: \(path)")
            return nil
        }
        
        guard let rawCreationDate = attributes[FileAttributeKey.creationDate] else {
            print("Could not read creation date attribute for item at path: \(path)")
            return nil
        }
        
        return rawCreationDate as? Date
    }
    
    private static func setCreationDateOfItem(atPath path: String, creationDate: Date) {
        let fileManager = FileManager()
        try? fileManager.setAttributes([FileAttributeKey.creationDate: creationDate], ofItemAtPath: path)
    }
    
    private static func adjustDateOfItem(atPath path: String, timeInterval: TimeInterval) {
        guard let creationDate = creationDateOfItem(atPath: path) else {
            return
        }
        let adjustedDate = creationDate.addingTimeInterval(timeInterval)
        setCreationDateOfItem(atPath: path, creationDate: adjustedDate)
        
        print("Adjusted date of \(path) from \(creationDate) to \(adjustedDate)")
    }
    
}
