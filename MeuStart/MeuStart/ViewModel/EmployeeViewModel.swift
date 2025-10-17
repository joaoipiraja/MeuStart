//
//  EmployeeViewModel.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//
//
import Foundation
import SwiftData

@MainActor
final class EmployeeViewModel: ObservableObject {
    @Published private(set) var employees: [Employee] = []
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchEmployees()
    }

    func fetchEmployees() {
        let descriptor = FetchDescriptor<Employee>(sortBy: [SortDescriptor(\.name)])
        do {
            employees = try context.fetch(descriptor)
        } catch {
            print("❌ Erro ao buscar colaboradores: \(error)")
        }
    }

    func addEmployee(name: String, role: String, manager: String?, status: EmployeeStatus) {
        let employee = Employee(name: name, role: role, manager: manager, status: status)
        context.insert(employee)
        saveChanges()
    }

    func deleteEmployee(_ employee: Employee) {
        context.delete(employee)
        saveChanges()
    }

    private func saveChanges() {
        do {
            try context.save()
            fetchEmployees()
        } catch {
            print("❌ Erro ao salvar alterações: \(error)")
        }
    }
}
