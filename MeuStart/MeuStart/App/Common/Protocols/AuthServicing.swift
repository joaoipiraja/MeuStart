//
//  AuthServicing.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//

import Foundation

protocol AuthServicing {
    func login(email: String, password: String) async throws
}

/// Implemente com sua API; aqui é só mock
struct MockAuthService: AuthServicing {
    func login(email: String, password: String) async throws {
        try await Task.sleep(nanoseconds: 1_200_000_000)
    }
}
