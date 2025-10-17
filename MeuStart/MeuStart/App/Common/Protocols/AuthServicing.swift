//
//  AuthServicing.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//
import Foundation
import SwiftData

// MARK: - Protocolo comum
protocol AuthServicing {
    func login(email: String, password: String) async throws -> User
}

// MARK: - Serviço real (SwiftData)
@MainActor
struct AuthService: AuthServicing {
    let context: ModelContext

    func login(email: String, password: String) async throws -> User {
        print("🔍 Tentando login com \(email) / \(password)")
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { user in
                user.email == email && user.password == password
            }
        )
        let users = try context.fetch(descriptor)
        guard let user = users.first else {
            throw AuthError.invalidCredentials
        }
        return user
    }
}

// MARK: - Mock (para previews ou testes)
struct MockAuthService: AuthServicing {
    func login(email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 1_200_000_000) // simula delay de rede
        return User(
            name: "Usuário Mock",
            email: email,
            password: password,
            role: "Mock",
            isAdmin: false
        )
    }
}

// MARK: - Erros de autenticação
enum AuthError: LocalizedError {
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "E-mail ou senha incorretos."
        }
    }
}
