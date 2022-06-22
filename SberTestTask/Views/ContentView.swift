//
//  ContentView.swift
//  SberTestTask
//
//  Created by Матвей on 17.06.2022.
//

import SwiftUI
import Combine
import MessageUI

struct ContentView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var isShowingTableView = true
    
    @EnvironmentObject var contactViewModel: ContactViewModel
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        if isShowingTableView == true {
            List {
                ForEach(contactViewModel.contacts) { contact in
                    ContentRow(contact: contact, image: $contactViewModel.images[contact])
                    }
                .onDelete(perform: contactViewModel.delete)
                }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        self.isShowingTableView.toggle()
                    } label: {
                        Label("Поменять вид", systemImage: "tablecells")
                    }
                    
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Добавить", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.isShowingMailView.toggle()
                    } label: {
                        Label("Share Item", systemImage: "square.and.arrow.up")
                    }
                }
            }
            .navigationBarTitle("Контакты", displayMode: .inline)
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result, newMessageBody: messageBody())
            }
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(contactViewModel.contacts) { contact in
                        CardView(contact: contact, image: $contactViewModel.images[contact])
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        self.isShowingTableView.toggle()
                    } label: {
                        Label("Поменять вид", systemImage: "list.dash")
                    }
                    
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Добавить", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.isShowingMailView.toggle()
                    } label: {
                        Label("Share Item", systemImage: "square.and.arrow.up")
                    }
                }
            }
            .navigationBarTitle("Контакты", displayMode: .inline)
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result, newMessageBody: messageBody())
            }
        }
    }

    
    func messageBody() -> String {
        var message: String = ""
        for contact in contactViewModel.contacts {
            message += "Имя: " + contact.name + ", " + "номер: " + contact.number + ". "
        }
        return message
    }
}
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .environmentObject(ContactViewModel())
    }
}
