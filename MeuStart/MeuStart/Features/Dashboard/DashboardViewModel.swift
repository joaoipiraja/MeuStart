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
    @Published var selectedEmployee: Employee? = nil
    // Exemplo de filtro e ordenação
    @Published var selectedFilter: FilterOption = .all
    @Published var selectedSort: SortOption = .name
    
    // Lista de colaboradores (mock)
    @Published var employees: [Employee] = [
        .init(name: "André de Lima Freitas",role: "Product Designer", manager: "Marcelo Farias", status: .completed, startDate: "12/08/2019"),
        .init(name: "Manoel Gomes Ferreira", role: "Auxiliar Administrativo", manager: "Carlos Souza", status: .delayed, startDate: "05/09/2023"),
        .init(name: "Beatriz Maria Andrade", role: "Analista Financeiro", manager: "Juliana Silveira",status: .atention, startDate: "20/20/2020"),
        .init(name: "Clarisse Souza Dourado",role: "Diretora de Marketing", manager: "Marcos Pasquim", status: .atention, startDate: "12/02/2012")
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
