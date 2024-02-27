//
//  InstagramCloneProjectApp.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/26.
//

import SwiftUI

@main
struct InstagramCloneProjectApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            FirstView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
