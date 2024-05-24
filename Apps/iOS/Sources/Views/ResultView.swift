// ResultView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct ResultView: View {
    @Environment(\.chatGPT) var chatGPT
    var body: some View {
        NavigationStack {
            List {
                ForEach(chatGPT.chatResults, id: \.id) { chatResult in
                    Text(chatResult.choices.first?.message.content?.string ?? "-")
                }
            }
        }
    }
}

#Preview {
    ResultView()
}

// guard let resultString = result.choices.first?.message.content?.string?.stripCodeBlock(),
//      let resultData = resultString.data(using: .utf8)
// else {
//    return
// }
