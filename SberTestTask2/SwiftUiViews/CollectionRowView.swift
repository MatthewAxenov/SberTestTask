//
//  CollectionRowView.swift
//  SberTestTask2
//
//  Created by Матвей on 23.06.2022.
//

import SwiftUI

struct CollectionRowView: View {
    
    @ObservedObject var contact: Contact
    
    var body: some View {
        ZStack() {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("LightGreen"))
                    .shadow(radius: 10)
                HStack() {
                    if let data = contact.image, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(40)
                    } else {
                        let icon = SwiftUI.Image(systemName: "person")

                        icon
                          .resizable()
                          .scaledToFill()
                          .frame(width: 80, height: 80)
                          .font(Font.title.weight(.light))
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text(contact.name ?? "")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        Text(contact.number ?? "")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 9))
                            .lineLimit(1)
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 120)
    }
}

struct CollectionRowView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRowView(contact: Contact())
    }
}
