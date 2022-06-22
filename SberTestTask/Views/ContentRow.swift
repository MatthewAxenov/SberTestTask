//
//  ContentRow.swift
//  SberTestTask
//
//  Created by Матвей on 21.06.2022.
//

import SwiftUI

struct ContentRow: View {
    @ObservedObject var contact: Contact
    @Binding var image: Image?

    
    var body: some View {
        NavigationLink(destination: DetailedView(contact: contact, image: $image)) {
            HStack(spacing: 20) {
                Contact.Image(image: image, size: 80, cornerRadius: 40)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(contact.name)
                    Text(contact.number)
                }
            }
        }
    }
}

struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow(contact: Contact(name: "non", number: "444"), image: .constant(nil))
    }
}
