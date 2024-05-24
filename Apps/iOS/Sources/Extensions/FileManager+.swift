// FileManager+.swift
// Copyright (c) 2024 Submap

import Foundation

extension FileManager {
    var documentsDirectory: URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to find user's documents directory")
        }
        return url
    }

    func urlInDocumentsDirectory(named: String) -> URL {
        documentsDirectory.appendingPathComponent(named)
    }
}
