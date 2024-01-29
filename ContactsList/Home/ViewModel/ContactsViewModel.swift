//
//  ContactsViewModel.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import Foundation
import Combine
import SwiftUI

class ContactsViewModel: ObservableObject {
    @Published var activeContacts: [Contacts] = []
    @Published var image: UIImage? = nil
    
    private var contactsCancellables = Set<AnyCancellable>()
    

    
    init() {
        fetchContacts()
        downloadImages()
    }
    
    private func fetchContacts() {
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else { return }
        NetworkingManager.download(url: url)
            .decode(type: [Contacts].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] name in
                self?.activeContacts = name.filter { $0.status == "active" }
            }
            .store(in: &contactsCancellables)
    }
    
    private func downloadImages() {
        guard let imageUrl = URL(string: "https://picsum.photos/200/200") else { return }
               
               URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                   guard let data = data, error == nil else {
                       print("Failed to load image:", error?.localizedDescription ?? "Unknown error")
                       return
                   }
                   DispatchQueue.main.async {
                       self.image = UIImage(data: data)
                   }
               }.resume()
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
