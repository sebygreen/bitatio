//
//  ContentView.swift
//  Bitatio
//
//  Created by Sebastien Green on 27/03/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Group {
            if (authManager.authenticated) {
                TabView {
                    HomeScreen()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    ProfileScreen()
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                }
            } else {
                WelcomeScreen()
            }
        }
        .animation(.easeInOut(duration: 0.2), value: authManager.authenticated == false)
        .transition(.slide)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthManager())
    }
}
