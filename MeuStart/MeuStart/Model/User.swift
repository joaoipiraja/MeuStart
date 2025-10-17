//
//  User.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 14/10/25.
//
//
//import SwiftData
//import Foundation
//
//@Model
//final class User {
//    var id: UUID
//    var name: String
//    var email: String
//    var employees: [Employee] = []
//
//    init(
//        id: UUID = UUID(),
//        name: String,
//        email: String
//    ) {
//        self.id = id
//        self.name = name
//        self.email = email
//    }
//}
//
//  User.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//

//
//import Foundation
//import SwiftData
//
//@Model
//final class User {
//    var name: String
//    var email: String
//    var password: String
//    var role: String
//    var isAdmin: Bool
//
//    init(name: String, email: String, password: String, role: String, isAdmin: Bool = false) {
//        self.name = name
//        self.email = email
//        self.password = password
//        self.role = role
//        self.isAdmin = isAdmin
//    }
//}

//
//  User.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import Foundation
import SwiftData

@Model
final class User {
    // MARK: - Identificação
    var name: String
    var email: String
    var password: String
    var role: String // Cargo
    var isAdmin: Bool

    // MARK: - Dados de Colaborador
    var manager: String?
    var statusRawValue: Int
    var startDate: Date

    // MARK: - Relações
    @Relationship(deleteRule: .cascade, inverse: \TaskItem.user)
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
        email: String,
        password: String,
        role: String,
        isAdmin: Bool = false,
        manager: String? = nil,
        status: EmployeeStatus = .atention,
        startDate: Date = .now
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.role = role
        self.isAdmin = isAdmin
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

