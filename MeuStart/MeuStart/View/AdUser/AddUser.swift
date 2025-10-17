//
//  AddUser.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//
//
//  AddUserView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import SwiftUI
import SwiftData

struct AddUserView: View {
    @ObservedObject var userVM: UserViewModel

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var role = ""
    @State private var manager = ""
    @State private var isAdmin = false
    @State private var status: EmployeeStatus = .atention

    var body: some View {
        Form {
            // MARK: - Informações básicas
            Section(header: Text("Informações do Usuário")) {
                TextField("Nome", text: $name)
                TextField("E-mail", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                SecureField("Senha", text: $password)
                TextField("Cargo", text: $role)
                TextField("Gestor", text: $manager)
            }

            // MARK: - Tipo de usuário
            Section(header: Text("Permissão")) {
                Toggle("Administrador", isOn: $isAdmin)
            }

            // MARK: - Status do colaborador
            Section(header: Text("Status")) {
                Picker("Status", selection: $status) {
                    Text("Atenção").tag(EmployeeStatus.atention)
                    Text("Atrasado").tag(EmployeeStatus.delayed)
                    Text("Concluído").tag(EmployeeStatus.completed)
                }
                .pickerStyle(.segmented)
            }

            // MARK: - Botão salvar
            Section {
                Button("Salvar") {
                    addUser()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .disabled(name.isEmpty || email.isEmpty || password.isEmpty)
            }
        }
        .navigationTitle("Novo Usuário")
    }

    // MARK: - Lógica de criação
    private func addUser() {
        userVM.addUser(
            name: name,
            email: email,
            password: password,
            role: role,
            isAdmin: isAdmin,
            manager: manager.isEmpty ? nil : manager,
            status: status
        )
        clearFields()
    }

    private func clearFields() {
        name = ""
        email = ""
        password = ""
        role = ""
        manager = ""
        isAdmin = false
        status = .atention
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: configuration)
        let context = ModelContext(container)
        let userVM = UserViewModel(context: context)

        return NavigationStack {
            AddUserView(userVM: userVM)
        }
    } catch {
        return Text("❌ Erro no Preview: \(error.localizedDescription)")
    }
}
