//
//  CreateView.swift
//  Bitatio
//
//  Created by Sebastien Green on 11/04/2023.
//

import SwiftUI
import PhotosUI

struct CreateGroupView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var authManager: AuthManager
    
    @State private var selected: [PhotosPickerItem] = []
    @State private var file: Data?
    
    @State var image: URL = URL(string: "https://gjidiruxdhxyhcnqhbrz.supabase.co/storage/v1/object/sign/avatars/Blini%20Cat.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhdmF0YXJzL0JsaW5pIENhdC5qcGciLCJpYXQiOjE2Nzk0OTY5ODcsImV4cCI6MTY4MDEwMTc4N30.FV0FQqu-sj67i8c2-GRcQ0anrf3erlF5ngRmXNbfsdI&t=2023-03-22T14%3A56%3A27.542Z")!
    @State var name: String = ""
    @State var address: String = ""
    @State var description: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Clos du Roy", text: $name)
                } header: {
                    Text("Name")
                }
                HStack (alignment: .bottom) {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Image")
                            .font(.caption)
                            .textCase(.uppercase)
                            .padding(.leading)
                            .opacity(0.5)
                        PhotosPicker(
                            selection: $selected,
                            maxSelectionCount: 1,
                            matching: .images,
                            photoLibrary: .shared())
                        {
                            HStack {
                                Text("Select")
                                    .font(.title3).bold()
                                Spacer()
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .font(.system(size: 24))
                                    .symbolRenderingMode(.hierarchical)
                            }
                            .padding()
                            .background(Color.accentColor.opacity(0.1))
                            .foregroundColor(Color.accentColor)
                            .cornerRadius(10)
                        }
                        .listRowInsets(EdgeInsets())
                        .onChange(of: selected) {
                            item in
                            guard
                                let item = selected.first
                            else {
                                return
                            }
                            item.loadTransferable(type: Data.self) {
                                result in
                                switch result {
                                case.success(let data):
                                    if (data != nil) {
                                        self.file = data
                                    } else {
                                        print("Data is nil")
                                    }
                                case.failure(let failure):
                                    fatalError("\(failure)")
                                }
                            }
                        }
                    }
                    Spacer()
                    if (file != nil) {
                        let image = UIImage(data: file!)!
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(10, antialiased: true)
                    } else {
                        Image(systemName: "doc.fill")
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 100, height: 100, alignment: .center)
                            .background(Color.primary.opacity(0.1))
                            .cornerRadius(10, antialiased: true)
                            .font(.system(size: 48))
                    }
                }
                .listRowInsets(.init())
                .listRowBackground(Color.clear)
                Section {
                    TextField("3 Flour Road", text: $address)
                } header: {
                    Text("Address")
                }
                Section {
                    TextField("The best building...", text: $description)
                } header: {
                    Text("Description")
                }
                Button {
                    // create
                } label: {
                    HStack {
                        Text("Next")
                            .font(.title3).bold()
                        Spacer()
                        if (authManager.loading.register) {
                            ProgressView()
                                .tint(Color.white)
                        } else {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 24))
                        }
                    }
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(Color.white)
                }
                .listRowInsets(.init())
            }
            .buttonStyle(.borderless)
            .navigationTitle("Create Group")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 24))
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            })
            .disabled(authManager.loading.register)
        }
        .sheet(item: $errorManager.current) { error in
            ErrorView(errorModel: error)
        }
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
            .environmentObject(ErrorManager())
            .environmentObject(AuthManager())
    }
}
