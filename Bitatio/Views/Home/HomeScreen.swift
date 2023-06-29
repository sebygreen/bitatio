//
//  HomeScreen.swift
//  Bitatio
//
//  Created by Sebastien Green on 03/04/2023.
//

import SwiftUI

struct HomeScreen: View {
    enum Sheet: String, Identifiable {
        case create, join
        var id: String { rawValue }
    }
    
    @State private var sheet: Sheet?
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 10) {
                Image(systemName: "questionmark.app.fill")
                    .font(.system(size: 64))
                    .symbolRenderingMode(.hierarchical)
                Text("Not a member of any group")
                    .multilineTextAlignment(.center)
                    .opacity(0.5)
                    .padding([.bottom], 50)
                HStack {
                    Button {
                        sheet = .create
                    } label: {
                        HStack  (spacing: 20) {
                            Text("Create")
                                .font(.title2)
                                .bold()
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                        }
                        .padding()
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(10, antialiased: true)
                    }
                    Button {
                        sheet = .join
                    } label: {
                        HStack (spacing: 20) {
                            Text("Join")
                                .font(.title2)
                                .bold()
                            Image(systemName: "person.fill.badge.plus")
                                .font(.system(size: 24))
                                .symbolRenderingMode(.hierarchical)
                        }
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10, antialiased: true)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .padding()
            .sheet(item: $sheet, content: { sheet in
                switch sheet {
                case .create:
                    CreateGroupView()
                case .join:
                    Text("Join")
                }
            })
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
