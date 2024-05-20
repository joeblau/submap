//
//  CNContact+.swift
//  Submap
//
//  Created by Joe Blau on 11/10/23.
//

import Contacts
import SwiftUI

extension CNContact: Structurable {
    var data: [String : String] {
        var contactInfo: [String: String] = .init()
        
        contactInfo["First Name"] = givenName
        contactInfo["Middle Name"] = middleName
        contactInfo["Family Mame"] = familyName
        contactInfo["Organization Name"] = organizationName
        contactInfo["Department Name"] = departmentName
        contactInfo["Job Title"] = jobTitle
        contactInfo["Nickname"] = nickname
    
        phoneNumbers.forEach { phoneNumber in
            if let label = phoneNumber.label {
                let localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label).localizedCapitalized
                contactInfo["\(localizedLabel) Phone"] = phoneNumber.value.stringValue
            }
        }
        
        if let birthday = birthday,
           let birthDate = Calendar.current.date(from: birthday) {
            
            let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date())
            
            contactInfo["Birthday"] = birthDate.formatted(date: .long, time: .omitted)
            if let year = age.year {
                switch year {
                case 1: contactInfo["Age"] = "\(year) Year Old"
                default: contactInfo["Age"] = "\(year) Years Old"
                }
            }
        }
        
        return contactInfo
    }
    
    var prompt: String {
        """
        # My Contact Information
        \(data.renderedAsFacts)
        """
    }
}

extension CNContact {
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    static func serialize(contact: CNContact) -> Data? {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: contact, requiringSecureCoding: true)
        } catch {
            print("Failed to serialize contact: \(error)")
            return nil
        }
    }
    
    static func deserialize(data: Data?) -> CNContact? {
        guard let data = data else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: CNContact.self, from: data)
        } catch {
            print("Failed to deserialize contact: \(error)")
            return nil
        }
    }
    
    var initials: String {
        return (givenName.first?.uppercased() ?? "") + (familyName.first?.uppercased() ?? "")
    }
    
    var fullName: String {
        return givenName.uppercased() + " " + familyName.uppercased()
    }
    
    var initialsText: Text {
        switch contactType {
        case .organization: Text(Image(systemName: "party.popper.fill"))
        case .person: Text(initials)
        @unknown default: Text(Image(systemName: "questionmark.square.dashed"))
        }
    }
}
