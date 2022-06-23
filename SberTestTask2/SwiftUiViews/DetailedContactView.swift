//
//  DetailedContactView.swift
//  SberTestTask2
//
//  Created by Матвей on 23.06.2022.
//

import SwiftUI

struct DetailedContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var contact: Contact
    
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    @State var isImagePicker: Bool = false
    @State var isCameraPicker: Bool = false
    
    
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            if coreDataVM.selectedImage == UIImage() {
                if let data = contact.image, let uiImage = UIImage(data: data) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .cornerRadius(125)
                }
            } else {
                Image(uiImage: coreDataVM.selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .cornerRadius(125)
            }
                            
            TextField(contact.name ?? "Имя", text: $coreDataVM.name)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField(contact.number ?? "Номер", text: $coreDataVM.number)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding()
                        
            
            HStack {
                Image(systemName: "camera.circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .font(.system(size: 50))
                    .onTapGesture {
                        self.isCameraPicker = true
                }
                
                Image(systemName: "photo.circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .font(.system(size: 50))
                    .onTapGesture {
                        self.isImagePicker = true
                }
            }
            
        
                    
            Button(action: {
                coreDataVM.editContact(contact: contact)
                withAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Сохранить")
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
        }
        .navigationTitle("Редактировать контакт")
        .padding()
        .sheet(isPresented: $isImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM.selectedImage)
        })
        .sheet(isPresented: $isCameraPicker, content: {
            ImagePicker(sourceType: .camera, selectedImage: $coreDataVM.selectedImage)
        })
    }
    
    
}

struct DetailedContactView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedContactView(contact: Contact())
    }
}
