//
//  textbridgeApp.swift
//  textbridge
//
//  Created by Roman Makarskiy on 04.02.2024.
//

import SwiftUI
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let typeTextShortcuts = Self("typeTextShortcuts")
}

@main
struct textBridgeApp: App {
    @State private var textModel = TextModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(textModel)
        }
    }
}
