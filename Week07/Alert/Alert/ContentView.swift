//
//  ContentView.swift
//  Alert
//
//  Created by Tamanna Jain on 4/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingRenameDialog = false
    @State private var newName = ""

    var body: some View {
        VStack {
            Button("Rename File") {
                showingRenameDialog = true
            }
        }
        .sheet(isPresented: $showingRenameDialog) {
            RenameDialog(newName: $newName, isPresented: $showingRenameDialog)
        }
    }
}

struct RenameDialog: View {
    @Binding var newName: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter a new name")
            TextField("New name", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("OK") {
                // Implement the renaming logic here
                print("Renaming to \(newName)")
                isPresented = false
            }
            Button("Cancel") {
                isPresented = false
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}


#Preview {
    ContentView()
}
