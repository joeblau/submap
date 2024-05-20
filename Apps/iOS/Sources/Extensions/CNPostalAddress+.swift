// CNPostalAddress+.swift
// Copyright (c) 2024 Submap

import Contacts
import Foundation

extension CNPostalAddress {
    func formattedAddress() -> String {
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: self)
    }
}
