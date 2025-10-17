//
//  UserManagerView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//

import SwiftUI
import SwiftData

struct UserManagerView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \User.name) private var users: [User]   // busca automática com SwiftData
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isAdmin = false
    @FocusState private var focus: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Lista de usuários
                List {
                    Section("Usuários cadastrados") {
                        ForEach(users) { user in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(user.isAdmin ? "Administrador" : "Colaborador")
                                    .font(.caption)
                                    .foregroundColor(user.isAdmin ? .blue : .green)
                            }
                        }
                        .onDelete(perform: deleteUser)
                    }
                }
                .listStyle(.insetGrouped)
                
                Divider()
                
                // Formulário de novo usuário
                VStack(alignment: .leading, spacing: 8) {
                    Text("Novo Usuário")
                        .font(.headline)
                    
                    TextField("Nome", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .focused($focus)
                    
                    TextField("E-mail", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Senha", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Toggle("Administrador", isOn: $isAdmin)
                    
                    Button(action: addUser) {
                        Label("Adicionar Usuário", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationTitle("Gerenciar Usuários")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }

    // MARK: - Funções CRUD
    private func addUser() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else { return }
        let user = User(name: name, email: email, password: password, role: isAdmin ? "Administrador" : "Colaborador", isAdmin: isAdmin)
        context.insert(user)
        do {
            try context.save()
            name = ""
            email = ""
            password = ""
            isAdmin = false
            focus = true
        } catch {
            print("❌ Erro ao salvar usuário: \(error)")
        }
    }

    private func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            context.delete(user)
        }
        do {
            try context.save()
        } catch {
            print("❌ Erro ao deletar usuário: \(error)")
        }
    }
}

#Preview {
    UserManagerView()
        .modelContainer(for: User.self)
}
