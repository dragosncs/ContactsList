//
//  ContactDetailView.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import SwiftUI

struct ContactDetailView: View {
    let contact: Contacts
    
    var body: some View {
        Text(contact.name)
            .navigationTitle(contact.name)
    }
}
