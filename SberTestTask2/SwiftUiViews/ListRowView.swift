//
//  ListRow.swift
//  SberTestTask2
//
//  Created by Матвей on 23.06.2022.
//

import SwiftUI

struct ListRowView: View {
    
    @ObservedObject var contact: Contact

    
    var body: some View {
    
            HStack(spacing: 20) {
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
                VStack(alignment: .leading, spacing: 15) {
                    Text(contact.name ?? "")
                    Text(contact.number ?? "")
                }
            }
        }
    }

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(contact: Contact())
    }
}
