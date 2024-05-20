//
//  CNPostalAddress+.swift
//  Submap
//
//  Created by Joe Blau on 11/12/23.
//

import Foundation
import Contacts

extension CNPostalAddress {
    func formattedAddress() -> String {
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: self)
    }
}
