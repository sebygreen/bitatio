//
//  ProfileScreen.swift
//  Bitatio
//
//  Created by Sebastien Green on 28/03/2023.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationStack {
            if userManager.loading.retreive {
                ProgressView("Retreiving profile...")
            }
            else {
                List {
                    HStack {
                        VStack (alignment: .leading) {
                            HStack {
                                Text(userManager.profile?.name ?? "Name")
                                    .font(.title)
                                Text(userManager.profile?.sirname ?? "Sirname")
                                    .font(.title)
                            }
                            Text(userManager.profile?.username ?? "username")
                                .bold()
                        }
                        Spacer()
                        // image
                        AsyncImage(url: userManager.profile?.avatar) {
                            image in image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.red
                        }
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                        .clipShape(Circle())
                    }
                    .listRowInsets(.init())
                    .listRowBackground(Color.clear)
                    Section {
                        Button {
                            // edit
                        } label: {
                            HStack {
                                Label("Edit", systemImage: "square.and.pencil")
                                if userManager.loading.edit {
                                    Spacer()
                                    ProgressView()
                                }
                            }
                        }
                        Button {
                            authManager.logout(errorManager: errorManager)
                        } label: {
                            HStack {
                                Label("Logout", systemImage: "power")
                                if authManager.loading.logout {
                                    Spacer()
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .disabled(userManager.loading.edit || authManager.loading.logout)
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.large)
                .refreshable {
                    await userManager.retreive(errorManager: errorManager)
                }
                .sheet(item: $errorManager.current) { error in
                    ErrorView(errorModel: error)
                }
            }
        }
        .task() {
            await userManager.retreive(errorManager: errorManager)
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .environmentObject(ErrorManager())
            .environmentObject(AuthManager())
            .environmentObject(UserManager())
    }
}
