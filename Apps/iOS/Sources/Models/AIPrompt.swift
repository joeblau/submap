//
//  AIPrompt.swift
//  Submap
//
//  Created by Joe Blau on 5/23/24.
//

import SwiftUI

struct AIPrompt {
    var user: String
    var location: Location
    var events: Events
    
    var system: String {
        """
        You are a personal assistant designed to help find the best
        answer to any questions.
        
        The response should be a json file populating fields that are
        relevent to the response.
        
        interface ApiResponse {
          response: string;
          card?: {
            coord?: {
              lat: number;
              lng: number;
            };
            list?: Array<{
              title: string;
              time?: Date;
            }>;
          };
        }
        
        The information below are all truthful facts about the state
        of the world:
        
        \(Calendar.current.prompt)
        \(location.currentLocation.prompt)
        \(events.calendars.prompt)
        \(events.calendarEvents.prompt)
        \(events.reminders.prompt)
        """
    }

}
