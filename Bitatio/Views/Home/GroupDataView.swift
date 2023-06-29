//
//  GroupDataView.swift
//  Bitatio
//
//  Created by Sebastien Green on 29/06/2023.
//

import SwiftUI

struct GroupDataView: View {
    @State private var text: String = ""
    private var pdfUrl: URL = URL(string: "https://www.annemasse-agglo.fr/sites/default/files/2022-02/MAQ_20220202_GUIDE-COMPOSTAGE_BD_2.pdf")!
    
    private struct CustomHeader: View {
        let text: String
        
        var body: some View {
            Text(text)
                .font(.title3)
                .bold()
                .textCase(nil)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: CustomHeader(text: "Dashboard")) {
                    HomeDetailsView()
                    NavigationLink {
                        DetailsView()
                            .navigationTitle("Dashboard")
                    } label: {
                        Label("Dashboard", systemImage: "rectangle.3.group.fill")
                    }
                    NavigationLink {
                        DetailsView()
                            .navigationTitle("Community")
                    } label: {
                        Label("Community", systemImage: "person.2.fill")
                    }
                    NavigationLink {
                        DetailsView()
                            .navigationTitle("Reports")
                    } label: {
                        Label("Reports", systemImage: "eye.trianglebadge.exclamationmark.fill")
                    }
                }
                Section (header: CustomHeader(text: "Compost")) {
                    HomeCompostView()
                        .listRowBackground(Color.white.opacity(0))
                        .listRowInsets(.init())
                }
                Section {
                    NavigationLink("Compost") {
                        ConciergeView()
                            .navigationTitle("Compost")
                    }
                    NavigationLink("Council Guidance") {
                        PDFKitView(url: pdfUrl)
                    }
                }
                Section(header: CustomHeader(text: "Concierge")) {
                    NavigationLink() {
                        ConciergeView()
                            .navigationTitle("Concierge")
                    } label: {
                        HomeConciergeView()
                    }
                }
                Section (header: CustomHeader(text: "Calendar")) {
                    HomeCalendarView()
                    NavigationLink {
                        CalendarView()
                            .navigationTitle("Calendar")
                    } label: {
                        Label("Calendar", systemImage: "calendar")
                    }
                }
            }
            .navigationTitle("Clos du Roy")
            .searchable(text: $text)
            .toolbar {
                Button {
                    //
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
                
            }
        }
    }
}

struct GroupDataView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDataView()
    }
}
