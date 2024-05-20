//
//  Contacts.swift
//  Submap
//
//  Created by Joe Blau on 5/20/24.
//

import SwiftUI
import Contacts

@Observable class Contacts {
    static var SETTING_CONTACT = "setting-contact"
    var selected: CNContact? = CNContact.deserialize(data: UserDefaults.standard.data(forKey: Contacts.SETTING_CONTACT)) {
        didSet {
            if let selectedContact = selected {
                UserDefaults.standard.setValue(CNContact.serialize(contact: selectedContact), forKey: Contacts.SETTING_CONTACT)
            }
        }
    }
}

struct ContactsKey: EnvironmentKey {
    static let defaultValue: Contacts = .init()
}

extension EnvironmentValues {
    var contacts: Contacts {
        get { self[ContactsKey.self] }
        set { self[ContactsKey.self] = newValue }
    }
}
