//
//  TextPrinter.swift
//  textbridge
//
//  Created by Roman Makarskiy on 05.02.2024.
//

import Foundation
import Cocoa
import Carbon.HIToolbox

func printText(_ model: TextModel) {
    let text = prepareText(model)
    
    for character in text.utf16 {
        if character == 10 {
            typeKey(keyCode: kVK_Return)
        } else {
            typeLetter(character: character)
        }
    }
}

func prepareText(_ model: TextModel) -> String {
    var text = model.text
    
    if (model.minimalize) {
        text = minimize(text)
    }
    
    if (model.decodeToBase64) {
        text = encodeToBase64(text)
    }
    
    return text
}

func minimize(_ input: String) -> String {
    let trimmedText = input.trimmingCharacters(in: .whitespacesAndNewlines)
    let components = trimmedText.components(separatedBy: .whitespacesAndNewlines)
    let minimizedText = components.joined()
    return minimizedText
}

func encodeToBase64(_ input: String) -> String {
    if let data = input.data(using: .utf8) {
        let base64EncodedString = data.base64EncodedString()
        return base64EncodedString
    }
    
    return input
}

private func typeKey(keyCode: Int) {
    postKeyEvent(keyCode: keyCode, keyDown: true)
    Thread.sleep(forTimeInterval: 0.01)
    
    postKeyEvent(keyCode: keyCode, keyDown: false)
    Thread.sleep(forTimeInterval: 0.01)
}

private func typeLetter(character: UniChar) {
    let slice: [UniChar] = [character]
    let eventSource = CGEventSource.init(stateID: CGEventSourceStateID.hidSystemState)
    let keyEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: CGKeyCode(0), keyDown: true)
    keyEvent?.keyboardSetUnicodeString(stringLength: 1, unicodeString: Array(slice))
    let loc = CGEventTapLocation.cghidEventTap
    
    keyEvent!.post(tap: loc)
    Thread.sleep(forTimeInterval: 0.01)
}

private func postKeyEvent(keyCode: Int, keyDown: Bool) {
    let eventSource = CGEventSource.init(stateID: CGEventSourceStateID.hidSystemState)
    let keyEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: CGKeyCode(keyCode), keyDown: keyDown)
    let loc = CGEventTapLocation.cghidEventTap
    keyEvent!.post(tap: loc)
}
