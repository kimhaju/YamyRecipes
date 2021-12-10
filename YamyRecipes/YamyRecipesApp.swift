//
//  YamyRecipesApp.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import SwiftUI
import Firebase

@main
struct YamyRecipesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("파이어 베이스 연동")
        FirebaseApp.configure()
        return true
    }
}
