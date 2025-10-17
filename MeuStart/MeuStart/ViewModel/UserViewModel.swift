//
//  EmployeeViewModel.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//
//
//
//  UserViewModel.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import Foundation
import SwiftData

@MainActor
final class UserViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchUsers()
    }

    // MARK: - Buscar usuários (colaboradores + admins)
    func fetchUsers() {
        let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
        do {
            users = try context.fetch(descriptor)
            print("📋 Usuários carregados: \(users.map { $0.email })")
        } catch {
            print("❌ Erro ao buscar usuários: \(error)")
        }
    }

    // MARK: - Criar novo usuário
    func addUser(
        name: String,
        email: String,
        password: String,
        role: String,
        isAdmin: Bool = false,
        manager: String? = nil,
        status: EmployeeStatus = .atention
    ) {
        let newUser = User(
            name: name,
            email: email,
            password: password,
            role: role,
            isAdmin: isAdmin,
            manager: manager,
            status: status
        )

        context.insert(newUser)
        saveChanges()
    }

    // MARK: - Excluir usuário
    func deleteUser(_ user: User) {
        context.delete(user)
        saveChanges()
    }

    // MARK: - Salvar alterações
    private func saveChanges() {
        do {
            try context.save()
            fetchUsers()
            print("💾 Alterações salvas com sucesso.")
        } catch {
            print("❌ Erro ao salvar alterações: \(error)")
        }
    }
}
