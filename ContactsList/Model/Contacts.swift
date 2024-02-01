//
//  Contacts.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import Foundation

struct Contacts: Identifiable, Codable {
    let id: Int
    let name: String
    let status: ContactStatus
}

enum ContactStatus: String, Codable {
    case active
    case inactive
    
}
