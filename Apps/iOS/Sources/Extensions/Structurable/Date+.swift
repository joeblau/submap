//
//  Date+.swift
//  Submap
//
//  Created by Joe Blau on 11/13/23.
//

import Foundation

extension Date: Structurable {

    var data: [String : String] {
        [
            "Date": Date().formatted(date: .long, time: .omitted),
            "Time": Date().formatted(date: .omitted, time: .complete)
        ]
    }
    
    var prompt: String {
        """
        # Date and Time
        \(data.renderedAsFacts)
        """
    }
}
