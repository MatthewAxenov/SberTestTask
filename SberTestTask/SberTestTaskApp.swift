//
//  SberTestTaskApp.swift
//  SberTestTask
//
//  Created by Матвей on 17.06.2022.
//

import SwiftUI

@main
struct SberTestTaskApp: App {
    
    @StateObject var contactViewModel: ContactViewModel = ContactViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(contactViewModel)
        }
    }
}
