//
//  ContactViewModel.swift
//  SberTestTask
//
//  Created by Матвей on 20.06.2022.
//

import Foundation
import SwiftUI

class ContactViewModel: ObservableObject {
    
    @Published var images: [Contact: Image] = [:]
    
    @Published var contacts: [Contact] = [
        Contact(name: "Максим", number: "8-977-834-87-34"),
        Contact(name: "Мария", number: "8-977-834-87-34"),
        Contact(name: "Александр", number: "8-977-834-87-34")
    ]
    
    func delete(at offset: IndexSet) {
        self.contacts.remove(atOffsets: offset)
    }
    
    func add(name: String, number: String) {
        let newContact = Contact(name: name, number: number)
        contacts.append(newContact)
    }
    
    func changeTitle(for contact: Contact, newName: String) {
       objectWillChange.send() 
       contact.name = newName
     }
}
    
