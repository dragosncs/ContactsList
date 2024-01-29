//
//  ContactsViewModel.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import Foundation

class ContactsViewModel: ObservableObject {
    @Published var activeContacts: [Contacts] = []
    
    
    init() {
        
    }
    
    
}
