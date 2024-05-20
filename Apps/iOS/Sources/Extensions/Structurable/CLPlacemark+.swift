// CLPlacemark+.swift
// Copyright (c) 2024 Submap

import CoreLocation
import Foundation

extension CLPlacemark: Structurable {
    var data: [String: String] {
        var placemarkInfo: [String: String] = .init()

        name.map { placemarkInfo["Name"] = $0 }
        thoroughfare.map { placemarkInfo["Thoroughfare"] = $0 }
        subThoroughfare.map { placemarkInfo["Sub Thoroughfare"] = $0 }
        locality.map { placemarkInfo["Locality"] = $0 }
        subLocality.map { placemarkInfo["Sub Locality"] = $0 }
        administrativeArea.map { placemarkInfo["Administrative Area"] = $0 }
        subAdministrativeArea.map { placemarkInfo["Sub Administrative Area"] = $0 }
        postalCode.map { placemarkInfo["Postal Code"] = $0 }
        isoCountryCode.map { placemarkInfo["ISO Country Code"] = $0 }
        country.map { placemarkInfo["Country"] = $0 }
        postalAddress.map { placemarkInfo["Postal Address"] = $0.formattedAddress() }
        inlandWater.map { placemarkInfo["Inland Water"] = $0 }
        ocean.map { placemarkInfo["Ocean"] = $0 }
        areasOfInterest.map { placemarkInfo["Areas Of Interest"] = $0.joined(separator: ", ") }

        return placemarkInfo
    }

    var prompt: String {
        """
        # My Placemark
        \(data.renderedAsFacts)
        """
    }
}
