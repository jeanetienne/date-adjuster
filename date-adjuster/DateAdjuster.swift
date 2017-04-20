//
//  DateAdjuster.swift
//  date-adjuster
//
//  Created by Jean-Étienne on 20/4/17.
//  Copyright © 2017 Jean-Étienne. All rights reserved.
//

import Foundation

struct DateAdjuster {
    
    static func adjustDateOfItems(atPaths paths: [String], withTimeInterval timeInterval: TimeInterval, modified: Bool) {
        for path in paths {
            adjustDateOfItem(atPath: path, timeInterval: timeInterval, modified: modified)
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
    
    private static func setDate(_ dateType: FileAttributeKey, date: Date, ofItemAtPath path: String) {
        let fileManager = FileManager()
        try? fileManager.setAttributes([dateType: date], ofItemAtPath: path)
    }
    
    private static func adjustDateOfItem(atPath path: String, timeInterval: TimeInterval, modified: Bool) {
        guard let creationDate = creationDateOfItem(atPath: path) else {
            return
        }
        let adjustedDate = creationDate.addingTimeInterval(timeInterval)
        setDate(FileAttributeKey.creationDate, date: adjustedDate, ofItemAtPath: path)
        
        if modified {
            setDate(FileAttributeKey.modificationDate, date: adjustedDate, ofItemAtPath: path)
        }
        
        print("Adjusted date of \(path) from \(creationDate) to \(adjustedDate)")
    }
    
}
