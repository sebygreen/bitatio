//
//  WelcomeScreen.swift
//  Bitatio
//
//  Created by Sebastien Green on 27/03/2023.
//

import SwiftUI

struct WelcomeScreen: View {
    enum Sheet: String, Identifiable {
        case login, register
        var id: String { rawValue }
    }
    
    @State private var sheet: Sheet?
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle).bold()
            HStack {
                Button {
                    sheet = .login
                } label: {
                    Text("Login")
                        .font(.title3)
                        .bold()
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10, antialiased: true)
                }
                Button {
                    sheet = .register
                } label: {
                    Text("Sign Up")
                        .font(.title3)
                        .bold()
                        .padding()
                        .background(Color.accentColor.opacity(0.1))
                        .foregroundColor(Color.accentColor)
                        .cornerRadius(10, antialiased: true)
                }
            }
        }
        .sheet(item: $sheet, content: { sheet in
            switch sheet {
            case .login:
                LoginView()
            case .register:
                RegisterView()
            }
        })
        .padding()
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
