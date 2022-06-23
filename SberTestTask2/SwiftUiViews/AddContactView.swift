//
//  AddContactView.swift
//  SberTestTask2
//
//  Created by Матвей on 22.06.2022.
//

import SwiftUI

struct AddContactView: View {
    @ObservedObject var coreDataVM = CoreDataViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State var isImagePicker: Bool = false
    @State var isCameraPicker: Bool = false
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            
            
            if coreDataVM.selectedImage != UIImage() {
                Image(uiImage: coreDataVM.selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .cornerRadius(125)
            }
            
                            
            TextField("Имя:", text: $coreDataVM.name)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField("Номер:", text: $coreDataVM.number)
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
                coreDataVM.addContact()
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
        .navigationTitle("Добавить контакт")
        .padding()
        .sheet(isPresented: $isImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM.selectedImage)
        })
        .sheet(isPresented: $isCameraPicker, content: {
            ImagePicker(sourceType: .camera, selectedImage: $coreDataVM.selectedImage)
        })
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
