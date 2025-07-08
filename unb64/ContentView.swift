//
//  ContentView.swift
//
//
//  Created by Montel Gray on 2025.07.08.
//


//
//  ContentView.swift
//  unb64
//
//

import SwiftUI

struct ContentView: View {
    @State private var base64Input: String = ""
    @State private var copyMessage: String? = nil
    
    var decodedOutput: String {
        guard let data = Data(base64Encoded: base64Input) else {
            return "Invalid Base64"
        }
        return String(data: data, encoding: .utf8) ?? "Decoded data is not valid UTF-8"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Base64 Input:")
                .font(.headline)
            
            ZStack(alignment: .topLeading) {
                if base64Input.isEmpty {
                    Text("Enter Base64 text here...")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.leading, 4)
                }
                TextEditor(text: $base64Input)
                    .padding(4)
                    .border(Color.gray)
            }
            .frame(minHeight: 120)
            
            Text("Decoded Output:")
                .font(.headline)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: .constant(decodedOutput))
                    .padding(4)
                    .border(Color.gray)
                    .disabled(true)
            }
            .frame(minHeight: 120)
            
            Button(action: {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(decodedOutput, forType: .string)
                copyMessage = "Copied!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    copyMessage = nil
                }
            }) {
                Label("Copy Decoded Text", systemImage: "doc.on.doc")
            }
            .padding(.top, 8)
            
            if let msg = copyMessage {
                Text(msg)
                    .foregroundColor(.green)
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
