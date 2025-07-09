//
//  unb64App.swift
//  unb64
//
//  Created by teezyyoxo on 2025.07.08.
//

import SwiftUI

@main
struct Unb64App: App {
    @StateObject private var fontSizeManager = FontSizeManager()

    var body: some Scene {
        WindowGroup {
            ContentView(fontSizeManager: fontSizeManager)
        }
        .commands {
            CommandMenu("Font Size") {
                Button("Increase Font Size") {
                    fontSizeManager.fontSize += 1
                }
                .keyboardShortcut("+", modifiers: [.command])

                Button("Decrease Font Size") {
                    fontSizeManager.fontSize = max(8, fontSizeManager.fontSize - 1)
                }
                .keyboardShortcut("-", modifiers: [.command])
            }
        }
    }
}
