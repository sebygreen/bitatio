//
//  BitatioApp.swift
//  Bitatio
//
//  Created by Sebastien Green on 27/03/2023.
//

import SwiftUI
import Supabase

let supabase = SupabaseClient(supabaseURL: Secrets.supabaseURL, supabaseKey: Secrets.supabaseKey)

@main
struct BitatioApp: App {
    @StateObject private var errorManager = ErrorManager()
    @StateObject private var authManager = AuthManager()
    @StateObject private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(errorManager)
                .environmentObject(authManager)
                .environmentObject(userManager)
        }
    }
}
