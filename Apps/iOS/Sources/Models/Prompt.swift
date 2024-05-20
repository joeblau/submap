//
//  Prompt.swift
//  Submap
//
//  Created by Joe Blau on 5/19/24.
//

import Foundation

struct Prompt {
    static func prefix(desire: String) -> String {
        """
        You are a personal assistant and life coach, your goal is to find
        the best answer to the next question.
        
        The most important question that I need the answer to is: \(desire)
        """
    }
    
    static func suffix() -> String {
        """
        Remember, you are my personal assistant. Please help with the question.
        """
    }
}
