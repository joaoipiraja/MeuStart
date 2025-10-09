//
//  Employee.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//

import Foundation
import SwiftUICore

struct Employee: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let manager: String?
    let status: EmployeeStatus
    let startDate: String?
    
}

enum EmployeeStatus: String, CaseIterable, Codable {
    case completed = "concluído"
    case delayed = "atrasado"
    case atention = "atenção"
}


