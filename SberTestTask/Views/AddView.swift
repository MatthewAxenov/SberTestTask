//
//  AddView.swift
//  SberTestTask
//
//  Created by Матвей on 20.06.2022.
//

import SwiftUI

struct AddView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @State var nameTextFieldText: String = ""
    @State var numberTextFieldText: String = ""
    @EnvironmentObject var contactViewModel: ContactViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            TextField("Введите имя", text: $nameTextFieldText)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            TextField("Введите номер", text: $numberTextFieldText)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            Button {
                saveButtonPressed()
            } label: {
                Text("Сохранить")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Добавить контакт")
        .padding()
    }
    
    func saveButtonPressed() {
        contactViewModel.add(name: nameTextFieldText, number: numberTextFieldText)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ContactViewModel())
    }
}
