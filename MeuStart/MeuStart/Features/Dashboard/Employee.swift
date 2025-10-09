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
    let status: EmployeeStatus
}

enum EmployeeStatus: String, CaseIterable, Codable {
    case completed
    case delayed
    case atention
}


