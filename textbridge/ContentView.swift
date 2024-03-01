//
//  ContentView.swift
//  textbridge
//
//  Created by Roman Makarskiy on 04.02.2024.
//

import SwiftUI
import Carbon
import Cocoa
import KeyboardShortcuts

struct ContentView: View {
    @Environment(TextModel.self) var textModel
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var seconds: Double = 5
    @State private var isRunning: Bool = false
    
    var body: some View {
        @Bindable var textModel = textModel
        
        VStack {
            Form {
                
                HStack {
                    Label("Enter text", systemImage: "text.alignleft")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    VStack {
                        let githubLogoImage = colorScheme == .dark ? "github-mark-white" : "github-mark"
                                
                        Image(githubLogoImage)
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .trailing)
                        
                        Text("Open Source")
                            .font(.subheadline)
                    }.onTapGesture {
                        if let url = URL(string: "https://github.com/Romancha/text-bridge") {
                            NSWorkspace.shared.open(url)
                        }
                    }
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                TextEditor(text: $textModel.text)
                    .frame(minWidth: 100, minHeight: 50)
                
                Toggle(isOn: $textModel.decodeToBase64) {
                    Text("Decode to base64")
                }
                
                Toggle(isOn: $textModel.minimalize) {
                    Text("Minimize")
                }
            }
        }
        .padding()
        
        Divider()
        
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Label("Type with", systemImage: "keyboard").font(.title)
                    
                    HStack {
                        Text("Delay (seconds):")
                        TextField(value: $seconds, formatter: NumberFormatter()) {}
                            .frame(width: 100)
                        
                        Button(action: {
                            startTyping()
                            
                        }) {
                            Text("Type")
                        }
                    }
                    
                    Form {
                        KeyboardShortcuts.Recorder("Shortcuts:", name: .typeTextShortcuts)
                    }
                }
                
                .disabled(isRunning)
            }
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            alignment: .bottomLeading)
    }
    
    private func startTyping() {
        isRunning = true
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            printText(textModel)
            
            isRunning = false
            
            print("Finish")
        }
    }
}

#Preview {
    ContentView()
        .environment(TextModel())
}
