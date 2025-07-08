//
//  ContentView.swift
//  unb64
//
//  Created by Montel Gray on 2025.07.08.
//

import SwiftUI

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
                VStack(alignment: .center) {
                    Text("Base64 Input:")
                        .font(.headline)
                    
                    ZStack(alignment: .topLeading) {
                        if base64Input.isEmpty {
                            Text("Enter Base64 here...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $base64Input)
                            .padding(4)
                            .border(Color.gray)
                    }
                    .frame(minHeight: 175)
                    
                    Button(action: {
                        base64Input = ""
                    }) {
                        Label("Clear", systemImage: "xmark.circle")
                    }
                }
                
                VStack(alignment: .center) {
                    Text("Plain Text Input:")
                        .font(.headline)
                    
                    ZStack(alignment: .topLeading) {
                        if plainTextInput.isEmpty {
                            Text("Enter plain text here...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $plainTextInput)
                            .padding(4)
                            .border(Color.gray)
                    }
                    .frame(minHeight: 175)
                    
                    Button(action: {
                        plainTextInput = ""
                    }) {
                        Label("Clear", systemImage: "xmark.circle")
                    }
                }
            }
            
            Divider()
                .padding(.vertical, 7.5)
            
            HStack(spacing: 20) {
                VStack(alignment: .center) {
                    Text("Decoded Output:")
                        .font(.headline)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: .constant(decodedOutput))
                            .padding(4)
                            .border(Color.gray)
                            .disabled(true)
                    }
                    .frame(minHeight: 100)
                    // "Copy Decoded Text" button
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(decodedOutput, forType: .string)
                        copyMessageLeft = "Copied Decoded Text!"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            copyMessageLeft = nil
                        }
                    }) {
                        Label("Copy Decoded Text", systemImage: "doc.on.doc")
                    }
                    .padding(.top, 4)
                    // Button end
                    if let msg = copyMessageLeft {
                        Text(msg)
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .center) {
                    Text("Encoded Output:")
                        .font(.headline)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: .constant(encodedOutput))
                            .padding(4)
                            .border(Color.gray)
                            .disabled(true)
                    }
                    .frame(minHeight: 100)
                    // "Copy encoded base64" button
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(encodedOutput, forType: .string)
                        copyMessageRight = "Copied Encoded Base64!"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            copyMessageRight = nil
                        }
                    }) {
                        Label("Copy Encoded Base64", systemImage: "doc.on.doc")
                    }
                    .padding(.top, 4)
                    // Button end
                    if let msg = copyMessageRight {
                        Text(msg)
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
