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
    
    var decodedOutput: String {
        guard let data = Data(base64Encoded: base64Input) else {
            return "Invalid Base64"
        }
        return String(data: data, encoding: .utf8) ?? "Decoded data is not valid UTF-8"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Base64 Input:")
                .font(.headline)
            TextEditor(text: $base64Input)
                .frame(minHeight: 100)
                .border(Color.gray)
            
            Text("Decoded Output:")
                .font(.headline)
            TextEditor(text: .constant(decodedOutput))
                .frame(minHeight: 100)
                .border(Color.gray)
                .disabled(true)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
