//
//  InputCleaner.swift
//  date-adjuster
//
//  Created by Jean-Étienne on 19/4/17.
//  Copyright © 2017 Jean-Étienne. All rights reserved.
//

import Foundation

struct InputCleaner {
    
    static func makeAbsolute(paths: [String]) -> [String] {
        return paths.map {
            return Path($0).absolute().string
        }
    }
    
}
