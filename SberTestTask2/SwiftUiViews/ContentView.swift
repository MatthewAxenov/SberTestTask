//
//  ContentView.swift
//  SberTestTask2
//
//  Created by Матвей on 22.06.2022.
//

import SwiftUI
import MessageUI

struct ContentView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Contact.name, ascending: true)])
    private var contacts: FetchedResults<Contact>
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    @State var isShowingMailView = false
    @State var result: Result<MFMailComposeResult, Error>? = nil

    
    @State var isShowingListView = true
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)


    
    var body: some View {
        if isShowingListView {
            NavigationView {
                List {
                    ForEach(contacts) { contact in
                        NavigationLink(destination: DetailedContactView(contact: contact)) {
                            ListRowView(contact: contact)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        coreDataVM.deleteContact(indexSet: indexSet, contacts: contacts)
                    })
                }
                .toolbar(content: myToolBarContent)
                .navigationBarTitle("Контакты", displayMode: .inline)
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: self.$result, newMessageBody: messageBody())
                }
            }
        } else {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(contacts) { contact in
                            NavigationLink(destination: DetailedContactView(contact: contact)) {
                                CollectionRowView(contact: contact)
                            }
                        }
                    }
                    .padding()
                }
                .toolbar(content: myToolBarContent)
                .navigationBarTitle("Контакты", displayMode: .inline)
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: self.$result, newMessageBody: messageBody())
                }
            }
        }
            
    }
    
    func messageBody() -> String {
        var message: String = "Мои контакты. "
        for contact in contacts {
            let description = "Имя: " + (contact.name ?? "") + ", " + "номер: " + (contact.number ?? "") + ". "
            message += description
        }
        return message
    }
    
    @ToolbarContentBuilder
        func myToolBarContent() -> some ToolbarContent {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isShowingListView.toggle()
                    print(coreDataVM.isShowingList)
                } label: {
                    if isShowingListView {
                        Label("Поменять вид", systemImage: "tablecells")
                    } else {
                        Label("Share Item", systemImage: "list.bullet")
                    }
                }
                
                NavigationLink {
                    AddContactView()
                } label: {
                    Label("Добавить", systemImage: "plus.circle")
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

