//
//  ContentView.swift
//  unb64
//
//  Created by teezyyoxo on 2025.07.08.
//

import SwiftUI

struct InputEditor: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let clearAction: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(.leading, 4)
                        .padding(.top, 6)
                }
                TextEditor(text: $text)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.clear)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white),
                        alignment: .bottom
                    )
            }
            .frame(minHeight: 100)

            Button(action: clearAction) {
                Label("Clear", systemImage: "xmark.circle")
            }
            .buttonStyle(StyledButton())
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
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            TextEditor(text: .constant(output))
                .foregroundColor(.white)
                .padding(4)
                .background(Color.clear)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white),
                    alignment: .bottom
                )
                .disabled(true)
                .frame(minHeight: 100)

            HStack {
                Spacer()
                Button(action: copyAction) {
                    Label(copyLabel, systemImage: "doc.on.doc")
                }
                .buttonStyle(StyledButton())
                Spacer()
            }

            if let msg = copyMessage {
                Text(msg)
                    .foregroundColor(.green)
                    .font(.caption)
            }
        }
    }
}

// Custom button style for hover effect + color
struct StyledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
            .font(.system(size: 14))
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
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 20/255, green: 30/255, blue: 48/255),
                                            Color(red: 36/255, green: 59/255, blue: 85/255)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    InputEditor(
                        title: "Base64 Input",
                        placeholder: "Enter Base64 here...",
                        text: $base64Input,
                        clearAction: { base64Input = "" }
                    )

                    InputEditor(
                        title: "Plain Text Input",
                        placeholder: "Enter plain text here...",
                        text: $plainTextInput,
                        clearAction: { plainTextInput = "" }
                    )
                }

                Divider()
                    .frame(height: 2)
                    .background(Color.blue)
                Divider()
                    .frame(height:2)
                    .background(Color.gray)
                Divider()
                    .frame(height: 2)
                    .background(Color.blue)

                HStack(spacing: 20) {
                    OutputEditor(
                        title: "Decoded Output",
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
                        copyLabel: "Copy Decoded"
                    )

                    OutputEditor(
                        title: "Encoded Output",
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
                        copyLabel: "Copy Encoded"
                    )
                }
            }
            .padding(15)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(1), radius: 30, x: 0, y: 8)
            .frame(maxWidth: 800)
            .frame(maxHeight: 1000)
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
