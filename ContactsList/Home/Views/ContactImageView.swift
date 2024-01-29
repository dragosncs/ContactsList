//
//  ContactImageViewswift.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import SwiftUI

struct ContactImageView: View {
    @StateObject var viewModel: ContactsViewModel
    
    var body: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } else {
            ProgressView()
        }
    }
}
