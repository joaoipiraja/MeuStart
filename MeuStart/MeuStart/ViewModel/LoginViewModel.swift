//
//  LoginViewModel.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//
//
//  LoginViewModel.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 30/09/25.
//
import SwiftUI
import SwiftData

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var loggedUser: User?  // 👈 novo
    @Published var shouldNavigate = false


    private var service: AuthServicing

    init(service: AuthServicing = MockAuthService()) {
        self.service = service
    }

    func setAuthService(_ service: AuthServicing) {
        self.service = service
    }

    var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func clearEmail() {
        email.removeAll()
    }

    func submit() {
        guard canSubmit, !isLoading else { return }
        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            do {
                let user = try await service.login(email: email, password: password)
                loggedUser = user // 👈 Atualiza na MainThread — garante a troca de view
                print("✅ Login de \(user.name) (\(user.isAdmin ? "Admin" : "Comum"))")
            } catch {
                errorMessage = (error as? LocalizedError)?.errorDescription ?? "Erro ao fazer login."
            }
            isLoading = false
        }
    }
    
    func logout() {
        loggedUser = nil
        shouldNavigate = false
        email = ""
        password = ""
        errorMessage = nil
    }

}
