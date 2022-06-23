//
//  SberTestTask2App.swift
//  SberTestTask2
//
//  Created by Матвей on 22.06.2022.
//

import SwiftUI

@main
struct SberTestTask2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
