//
//  ContentView.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import SwiftUI

struct ContactsListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0...9, id: \.self) { num in
                    if num % 2 == 0 {
                        roundedInitialsView(for: "DragosN")
                    }
                    else {
                        Text("Odd Number")
                    }
                }
            }
            .navigationTitle("Contactele Mele")
        }
       
    }
}

#Preview {
    ContactsListView()
}

extension ContactsListView {
    private func roundedInitialsView(for name: String) -> some View {
        let initials = "DN"
        return ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 50, height: 50)

            Text(initials)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
