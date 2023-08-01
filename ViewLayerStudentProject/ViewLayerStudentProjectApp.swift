//
//  ViewLayerStudentProjectApp.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/1.
//

import SwiftUI
import RealmSwift

@main
struct ViewLayerStudentProjectApp: SwiftUI.App {
        
    init() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        print("\(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "")")
    }
    
    var body: some Scene {
        WindowGroup {
//            SplashScreenView()
            TabBarView(region: .constant("Yangon"))
        }
    }
}
