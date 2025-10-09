//
//  DashboardViewModel.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 03/10/25.
//

import SwiftUI

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var showSheet: Bool = false
    
    // Exemplo de filtro e ordenação
    @Published var selectedFilter: FilterOption = .all
    @Published var selectedSort: SortOption = .name
    
    // Lista de colaboradores (mock)
    @Published var employees: [Employee] = [
        .init(name: "André de Lima Freitas",role: "Product Designer", status: .completed),
        .init(name: "Manoel Gomes Ferreira", role: "Auxiliar Administrativo", status: .delayed),
        .init(name: "Beatriz Maria Andrade", role: "Analista Financeiro",status: .atention),
        .init(name: "Clarisse Souza Dourado",role: "Diretora de Marketing", status: .atention)
    ]
    
    // MARK: - Opções de filtro e ordenação
    enum FilterOption: String, CaseIterable {
        case all = "Todos"
        case active = "Ativos"
        case delayed = "Em atraso"
        case completed = "Concluídos"
    }
    
    enum SortOption: String, CaseIterable {
        case name = "Nome"
        case status = "Status"
    }
    
    // MARK: - Métodos de negócio
    
    func filteredEmployees() -> [Employee] {
        switch selectedFilter {
        case .all:
            return employees
        case .active:
            return employees.filter { $0.status == .atention }
        case .delayed:
            return employees.filter { $0.status == .delayed }
        case .completed:
            return employees.filter { $0.status == .completed }
        }
    }
    
    func sortEmployees() {
        switch selectedSort {
        case .name:
            employees.sort { $0.name < $1.name }
        case .status:
            employees.sort { $0.status.rawValue < $1.status.rawValue }
        }
    }
}
