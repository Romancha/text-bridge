//
//  ModelData.swift
//  textbridge
//
//  Created by Roman Makarskiy on 08.02.2024.
//

import Foundation
import KeyboardShortcuts

@Observable
class TextModel: ObservableObject {
    var text = ""
    var minimalize = false
    var decodeToBase64 = false
    
    init() {
        KeyboardShortcuts.onKeyUp(for: .typeTextShortcuts) { [self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                printText(self)
            }
        }
    }
}
