//
//  LoginViewModel.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//

import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service: AuthServicing

    init(service: AuthServicing = MockAuthService()) {
        self.service = service
    }

    var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func clearEmail() {
        email.removeAll()
    }

    func submit() {
        guard canSubmit, !isLoading else { return }
        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await service.login(email: email, password: password)
                // TODO: navegação/sucesso
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
