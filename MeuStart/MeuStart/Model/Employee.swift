//
//  Employee.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//

import Foundation
import SwiftData
//
//struct Employee: Identifiable {
//    let id = UUID()
//    let name: String
//    let role: String
//    let manager: String?
//    let status: EmployeeStatus
//    let startDate: String?
//    
//}
//
//enum EmployeeStatus: String, CaseIterable, Codable {
//    case completed = "concluído"
//    case delayed = "atrasado"
//    case atention = "atenção"
//}
//
//  Employee.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//
//
//  Employee.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//

import Foundation
import SwiftData

@Model
final class Employee {
    // MARK: - Propriedades persistidas
    var name: String
    var role: String
    var manager: String?
    var statusRawValue: Int
    var startDate: Date

    // MARK: - Relações
    @Relationship(deleteRule: .cascade, inverse: \TaskItem.employee)
    var tasks: [TaskItem] = []

    // MARK: - Computadas
    var status: EmployeeStatus {
        get { EmployeeStatus(rawValue: statusRawValue) ?? .atention }
        set { statusRawValue = newValue.rawValue }
    }

    var statusString: String {
        switch status {
        case .atention: return "Atenção"
        case .delayed: return "Atrasado"
        case .completed: return "Concluído"
        }
    }

    var formattedStartDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: startDate)
    }

    // MARK: - Inicializador
    init(
        name: String,
        role: String,
        manager: String? = nil,
        status: EmployeeStatus = .atention,
        startDate: Date = .now
    ) {
        self.name = name
        self.role = role
        self.manager = manager
        self.statusRawValue = status.rawValue
        self.startDate = startDate
    }
}

// MARK: - Enum de Status
enum EmployeeStatus: Int, Codable, CaseIterable {
    case atention = 0
    case delayed = 1
    case completed = 2
}
