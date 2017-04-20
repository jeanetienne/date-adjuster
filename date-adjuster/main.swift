//
//  main.swift
//  date-adjuster
//
//  Created by Jean-Étienne on 19/4/17.
//  Copyright © 2017 Jean-Étienne. All rights reserved.
//

import Foundation

let cli = CommandLine()

let filePath = MultiStringOption(shortFlag: "f", longFlag: "file", required: true,
                                 helpMessage: "Path to the input file(s).")
let timeInterval = IntOption(shortFlag: "t", longFlag: "time-interval", required: true,
                             helpMessage: "Number of seconds to add (or take away if negative) from the original creation date.")
let modificationDate = BoolOption(shortFlag: "m", longFlag: "modification-date",
                                  helpMessage: "Also updates the modification date.")
let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")

cli.addOptions(filePath, timeInterval, modificationDate, help)

do {
    try cli.parse()

    if let rawTimeIntervalValue = timeInterval.value {
        let timeIntervalValue = Double(rawTimeIntervalValue) as TimeInterval
        
        if let paths = filePath.value {
            let absolutePaths = InputCleaner.makeAbsolute(paths: paths)
            DateAdjuster.adjustDateOfItems(atPaths: absolutePaths, withTimeInterval: timeIntervalValue, modified: modificationDate.value)
        }
    } else {
        print("Could not read the time interval")
    }
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}
