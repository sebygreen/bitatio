//
//  Profile.swift
//  Bitatio
//
//  Created by Sebastien Green on 04/04/2023.
//

import Foundation

@MainActor
class UserManager: ObservableObject {
    @Published var loading = Loading()
    @Published var profile: Profile?
    
    struct Loading {
        var retreive: Bool = true
        var edit: Bool = false
    }

    func retreive(errorManager: ErrorManager) async {
        do {
            let query = supabase.database
                .from("profiles")
                .select()
                .single()
            self.profile = try await query.execute().value
            // ok
            self.loading.retreive = false
        }
        catch {
            self.loading.retreive = false
            errorManager.current = ErrorModel(
                errorDescription: "Profile Error",
                errorReason: error.localizedDescription
            )
            return
        }
    }
}
