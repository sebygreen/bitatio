//
//  ErrorManager.swift
//  Bitatio
//
//  Created by Sebastien Green on 06/04/2023.
//

import Foundation

struct ErrorModel: LocalizedError, Identifiable {
    var id = UUID()
    var errorDescription: String
    var errorReason: String
}

class ErrorManager: ObservableObject {
    @Published var current: ErrorModel?
}
