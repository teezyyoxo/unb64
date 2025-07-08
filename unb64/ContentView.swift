//
//  ContentView.swift
//  unb64
//
//  Created by Montel Gray on 2025.07.08.
//

import SwiftUI

struct InputEditor: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let clearAction: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.headline)
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.leading, 4)
                }
                TextEditor(text: $text)
                    .padding(4)
                    .border(Color.gray)
            }
            .frame(minHeight: 175)
            
            Button(action: clearAction) {
                Label("Clear", systemImage: "xmark.circle")
            }
        }
    }
}

struct OutputEditor: View {
    let title: String
    let output: String
    let copyAction: () -> Void
    let copyMessage: String?
    let copyLabel: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.headline)
            
            TextEditor(text: .constant(output))
                .padding(4)
                .border(Color.gray)
                .disabled(true)
                .frame(minHeight: 100)
            
            Button(action: copyAction) {
                Label(copyLabel, systemImage: "doc.on.doc")
            }
            .padding(.top, 8)
            
            if let msg = copyMessage {
                Text(msg)
                    .foregroundColor(.green)
                    .font(.caption)
            }
        }
    }
}

struct ContentView: View {
    @State private var base64Input: String = ""
    @State private var plainTextInput: String = ""
    @State private var copyMessageLeft: String? = nil
    @State private var copyMessageRight: String? = nil
    
    var decodedOutput: String {
        guard let data = Data(base64Encoded: base64Input) else {
            return base64Input.isEmpty ? "" : "Invalid Base64"
        }
        return String(data: data, encoding: .utf8) ?? "Decoded data is not valid UTF-8"
    }
    
    var encodedOutput: String {
        let data = plainTextInput.data(using: .utf8) ?? Data()
        return data.base64EncodedString()
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                InputEditor(
                    title: "Base64 Input:",
                    placeholder: "Enter Base64 here...",
                    text: $base64Input,
                    clearAction: { base64Input = "" }
                )
                
                InputEditor(
                    title: "Plain Text Input:",
                    placeholder: "Enter plain text here...",
                    text: $plainTextInput,
                    clearAction: { plainTextInput = "" }
                )
            }
            
            Divider()
                .padding(.vertical, 7.5)
            
            HStack(spacing: 20) {
                OutputEditor(
                    title: "Decoded Output:",
                    output: decodedOutput,
                    copyAction: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(decodedOutput, forType: .string)
                        copyMessageLeft = "Copied Decoded Text!"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            copyMessageLeft = nil
                        }
                    },
                    copyMessage: copyMessageLeft,
                    copyLabel: "Copy Decoded Text"
                )
                
                OutputEditor(
                    title: "Encoded Output:",
                    output: encodedOutput,
                    copyAction: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(encodedOutput, forType: .string)
                        copyMessageRight = "Copied Encoded Base64!"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            copyMessageRight = nil
                        }
                    },
                    copyMessage: copyMessageRight,
                    copyLabel: "Copy Encoded Base64"
                )
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
