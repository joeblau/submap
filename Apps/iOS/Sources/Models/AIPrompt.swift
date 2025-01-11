// AIPrompt.swift
// Copyright (c) 2025 Submap

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
              date?: Date;
            }>;
            email?: {
              from: string;
              to: string;
              subject: string;
              message: string;
            }
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
