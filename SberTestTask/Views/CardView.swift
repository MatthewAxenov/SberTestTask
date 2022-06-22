//
//  CardView.swift
//  SberTestTask
//
//  Created by Матвей on 21.06.2022.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var contact: Contact
    @Binding var image: Image?
    
    var body: some View {
        NavigationLink(destination: DetailedView(contact: contact, image: $image)) {
            ZStack() {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("LightGreen"))
                    .shadow(radius: 10)
                HStack() {
                    Contact.Image(image: image, size: 80, cornerRadius: 45)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(contact.name)
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        Text(contact.number)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 9))
                            .lineLimit(1)
                    }
                }
            }
            .frame(height: 120)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(contact: Contact(name: "non", number: "8-977-813-23-34"), image: .constant(nil))
    }
}
