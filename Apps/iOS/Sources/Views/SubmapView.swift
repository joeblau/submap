// SubmapView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct SubmapView: View {
    @FocusState private var keyboardFocused: Bool
    @State var text: String = ""
    @State private var isResponsePresented: Bool = false
    @State private var isOnboardPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Rectangle()
                .fill(.blue)
                .overlay {}
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                    VStack(spacing: 0){
                        HStack(alignment: .bottom) {
                            Button {} label: {
                                Image(systemName: "switch.2")
                            }
                            Button {} label: {
                                Image(systemName: "wand.and.stars")
                            }
                            Button {
                                withAnimation { keyboardFocused.toggle() }
                            } label: {
                                HStack {
                                    Image(systemName: "keyboard.fill")
                                    Image(systemName: "hand.draw.fill")
                                }
                            }
                            Button {} label: {
                                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                            }
                        }.padding()
                        MapView()
                    }
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {} label: {
                            Image(systemName: "trash.fill")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        ProgressView()
                    }
                })
                .toolbarBackground(.hidden, for: .navigationBar)
                .ignoresSafeArea(.keyboard)
        }
        .background(.black)
    }
}

#Preview {
    SubmapView()
}
