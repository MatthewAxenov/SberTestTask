//
//  CoreDataViewModel.swift
//  SberTestTask2
//
//  Created by Матвей on 22.06.2022.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    @Published var name: String = ""
    @Published var number: String = ""
    @Published var selectedImage: UIImage = UIImage()
    
    @Published var isShowingList: Bool = true
    

    private func saveViewContext() {
        do{
            try viewContext.save()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    
    func editContact(contact: Contact) {
        let contact = contact
        if self.name != "" {
            contact.name = self.name
        }
        if self.number != "" {
            contact.number = self.number
        }
        if selectedImage != UIImage() {
            if let photoData = selectedImage.jpegData(compressionQuality: 0.1) {
                contact.image = photoData
            }
            saveViewContext()
        }
    }
    
    func addContact() {
        if self.name == "" || self.number == "" {
            return
        }
        let contact = Contact(context: viewContext)
        contact.name = self.name
        contact.number = self.number
        if let photoData = selectedImage.jpegData(compressionQuality: 0.1) {
            contact.image = photoData
        }
        saveViewContext()
    }
    
    func deleteContact(indexSet: IndexSet, contacts: FetchedResults<Contact>) {
        indexSet.map({contacts[$0]}).forEach { contact in
            viewContext.delete(contact)
            saveViewContext()
        }
    }
    
}
