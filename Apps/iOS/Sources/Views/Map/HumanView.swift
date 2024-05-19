//
//  HumanView.swift
//  Submap
//
//  Created by Joe Blau on 5/18/24.
//

import SwiftUI

struct HumanView: View {
    var body: some View {
        Menu {
            Section("Human") {
                Text("Joe Blau")
                Text("Male")
            }
            Section("Location") {
                Text("San Francisco")
                Text("USA")
            }
        } label: {
            Image(systemName: "figure.arms.open")
        }
        .buttonStyle(MaterialButtonStyle(active: .constant(false)))
    }
}

#Preview {
    HumanView()
}
