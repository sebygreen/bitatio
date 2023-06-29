//
//  User.swift
//  Bitatio
//
//  Created by Sebastien Green on 27/03/2023.
//

import Foundation

@MainActor
class AuthManager: ObservableObject {
    @Published var loading = Loading()
    @Published var sessionToken: String? = nil
    @Published var authenticated: Bool = false
    
    struct Loading {
        var login: Bool = false
        var register: Bool = false
        var logout: Bool = false
    }
    
    func login(
        errorManager: ErrorManager,
        email: String,
        password: String
    ) {
        loading.login = true
        Task {
            do {
                try await supabase.auth.signIn(
                    email: email,
                    password: password
                )
                // ok
                let session = try await supabase.auth.session
                // ok
                self.sessionToken = session.accessToken
                self.loading.login = false
                self.authenticated = true
            }
            catch {
                self.loading.login = false
                errorManager.current = ErrorModel(
                    errorDescription: "Login Error",
                    errorReason: error.localizedDescription
                )
                return
            }
        }
    }
    
    func register(
        errorManager: ErrorManager,
        email: String,
        password: String,
        name: String,
        sirname: String,
        username: String,
        avatar: URL
    ) {
        loading.register = true
        Task {
            do {
                try await supabase.auth.signUp(
                    email: email,
                    password: password,
                    data: [
                        "name": .string(name),
                        "sirname": .string(sirname),
                        "username": .string(username),
                        "avatar": .string(avatar.absoluteString)
                    ]
                )
                // if success
                let session = try await supabase.auth.session
                // if success
                self.sessionToken = session.accessToken
                self.loading.register = false
                self.authenticated = true
            }
            catch {
                self.loading.register = false
                errorManager.current = ErrorModel(
                    errorDescription: "Register Error",
                    errorReason: error.localizedDescription
                )
                return
            }
        }
    }
    
    func logout(errorManager: ErrorManager) {
        loading.logout = true
        Task {
            do {
                try await supabase.auth.signOut()
                // if success
                self.sessionToken = nil
                self.loading.logout = false
                self.authenticated = false
            }
            catch {
                self.loading.logout = false
                errorManager.current = ErrorModel(
                    errorDescription: "Logout Error",
                    errorReason: error.localizedDescription
                )
                return
            }
        }
    }
}
