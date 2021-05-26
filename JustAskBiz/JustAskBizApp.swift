//
//  JustAskBizzApp.swift
//  JustAskBizz
//
//  Created by Aleksandar Lekov on 21/05/2021.
//

import SwiftUI
import Firebase

@main
struct JustAskBizzApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LogInPageView()
//           questionsviewTest()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
      }
}
