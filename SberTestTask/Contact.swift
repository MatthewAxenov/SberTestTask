//
//  Contact.swift
//  SberTestTask
//
//  Created by Матвей on 17.06.2022.
//

import Foundation
import SwiftUI
import Combine

class Contact: ObservableObject {
  
    @Published var name: String
    @Published var number: String
    
    init(name: String = "Contact", number: String = "88888888888") {
      self.name = name
      self.number = number
    }
}

extension Contact: Hashable, Identifiable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
      lhs === rhs
    }
}


extension Contact {

    struct Image: View {
        let image: SwiftUI.Image?
        var size: CGFloat?
        let cornerRadius: CGFloat

        var body: some View {
          if let image = image {
            image
              .resizable()
              .scaledToFill()
              .frame(width: size, height: size)
              .cornerRadius(cornerRadius)
          } else {
            let icon = SwiftUI.Image(systemName: "person")

            icon
              .resizable()
              .scaledToFit()
              .frame(width: size, height: size)
              .font(Font.title.weight(.light))
          }
        }
  }
}



