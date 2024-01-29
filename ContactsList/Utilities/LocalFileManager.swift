//
//  LocalFileManager.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import Foundation

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {}

    private let contactsFileName = "myContacts.json"
 
    func loadContacts() -> [Contacts] {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Documents directory not found.")
            return []
        }
        let contactsFilePath = documentsDirectory.appendingPathComponent(contactsFileName)
        
        guard FileManager.default.fileExists(atPath: contactsFilePath.path) else {
            print("Error: Contacts file not found at \(contactsFilePath.path)")
            return []
        }
        do {
            let data = try Data(contentsOf: contactsFilePath)
            let contacts = try JSONDecoder().decode([Contacts].self, from: data)
            return contacts
        } catch {
            print("Error decoding contacts data:", error.localizedDescription)
            return []
        }
    }
    
    func saveContacts(_ contacts: [Contacts]) {
        do {
            let data = try JSONEncoder().encode(contacts)
            
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Error: Documents directory not found.")
                return
            }
            
            let contactsFilePath = documentsDirectory.appendingPathComponent(contactsFileName)
            try data.write(to: contactsFilePath)
        } catch {
            print("Error saving contacts:", error.localizedDescription)
        }
    }
}
