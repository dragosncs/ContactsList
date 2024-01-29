//
//  ContentView.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import SwiftUI

struct ContactsListView: View {
    @StateObject private var viewModel = ContactsViewModel()
    
    var body: some View {
        NavigationView {
            List (viewModel.activeContacts) { contact in
                NavigationLink(destination: ContactDetailView(contact: contact)) {
                    if contact.id % 2 == 0 {
                        roundedInitialsView(for: contact.name)
                    }
                    else {
                      
                    }
                    Text(contact.name)
                }
                }
            }
            .navigationTitle("Contactele Mele")
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
