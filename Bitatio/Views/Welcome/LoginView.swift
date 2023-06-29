//
//  LoginView.swift
//  Bitatio
//
//  Created by Sebastien Green on 27/03/2023.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var authManager: AuthManager
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                Button {
                    authManager.login(errorManager: errorManager, email: email, password: password)
                } label: {
                    HStack {
                        Text("Login")
                            .font(.title3).bold()
                        Spacer()
                        if (authManager.loading.login) {
                            ProgressView()
                                .tint(Color.white)
                        } else {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 24))
                        }
                    }
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                }
                .listRowInsets(.init())
            }
            .buttonStyle(.borderless)
            .navigationTitle("Login")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(Color.accentColor)
                            .font(.system(size: 24))
                    }
                }
            })
            .disabled(authManager.loading.login)
        }
        .navigationBarTitleDisplayMode(.large)
        .sheet(item: $errorManager.current) { error in
            ErrorView(errorModel: error)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ErrorManager())
            .environmentObject(AuthManager())
    }
}
