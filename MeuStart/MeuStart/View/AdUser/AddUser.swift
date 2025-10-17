//
//  AddUser.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//

import SwiftUI
import SwiftData

struct AddEmployeeView: View {
    @ObservedObject var employeeVM: EmployeeViewModel

    @State private var name = ""
    @State private var role = ""
    @State private var manager = ""
    @State private var status: EmployeeStatus = .atention

    var body: some View {
        Form {
            Section(header: Text("Informações")) {
                TextField("Nome", text: $name)
                TextField("Cargo", text: $role)
                TextField("Gestor", text: $manager)
            }

            Section(header: Text("Status")) {
                Picker("Status", selection: $status) {
                    Text("Atenção").tag(EmployeeStatus.atention)
                    Text("Atrasado").tag(EmployeeStatus.delayed)
                    Text("Concluído").tag(EmployeeStatus.completed)
                }
                .pickerStyle(.segmented)
            }

            Section {
                Button("Salvar") {
                    employeeVM.addEmployee(
                        name: name,
                        role: role,
                        manager: manager.isEmpty ? nil : manager,
                        status: status
                    )
                    clearFields()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Novo Colaborador")
    }

    private func clearFields() {
        name = ""
        role = ""
        manager = ""
        status = .atention
    }
}

#Preview {
    do {
        // Cria container temporário para preview
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Employee.self, configurations: configuration)
        let context = ModelContext(container)

        let employeeVM = EmployeeViewModel(context: context)
        return NavigationStack {
            AddEmployeeView(employeeVM: employeeVM)
        }
    } catch {
        return Text("❌ Erro no Preview: \(error.localizedDescription)")
    }
}
