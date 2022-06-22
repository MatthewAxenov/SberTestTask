//
//  DetailedView.swift
//  SberTestTask
//
//  Created by Матвей on 17.06.2022.
//

import SwiftUI

struct DetailedView: View {
    
    @ObservedObject var contact: Contact
    
    @Binding var image: Image?
    
    @State var showImagePicker: Bool = false
    @State var showCameraPicker: Bool = false
    @State var selectedImage = UIImage(systemName: "sun.max")!
    
    var body: some View {
        VStack() {
            VStack() {
                TextField("Имя", text: $contact.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                TextField("Номер", text: $contact.number)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            
            
            Contact.Image(image: image, cornerRadius: 15)
                .scaledToFit()
                .padding()
            
            HStack(spacing: 40) {
                
                Button {
                    self.showImagePicker.toggle()
                } label: {
                    Text("Выбрать фото")
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                }
                
                Button {
                    self.showCameraPicker.toggle()
                } label: {
                    Text("Снять фото")
                }
                .sheet(isPresented: $showCameraPicker) {
                    ImagePicker(sourceType: .camera, selectedImage: $image)
                }
            }
            
            
        }
        .navigationTitle("Редактировать контакт")
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(contact: Contact(name: "Bob", number: "888"), image: .constant(nil))
            .environmentObject(ContactViewModel())
    }
}
