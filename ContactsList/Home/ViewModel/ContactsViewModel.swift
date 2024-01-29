//
//  ContactsViewModel.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import Foundation
import Combine

class ContactsViewModel: ObservableObject {
    @Published var activeContacts: [Contacts] = []
    
    private var contactsCancellables = Set<AnyCancellable>()
    

    
    init() {
        fetchContacts()
    }
    
    func fetchContacts() {
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else { return }
        NetworkingManager.download(url: url)
            .decode(type: [Contacts].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] name in
                self?.activeContacts = name.filter { $0.status == "active" }
            }
            .store(in: &contactsCancellables)
    }
    
    func extractInitials(for name: String) -> String {
        var initials = ""
        name
            .replacing("\n", with: "")
            .split(separator: " ")
            .forEach { substring in
                initials += String(substring.first ?? Character(""))
            }
        return initials
    }
}
