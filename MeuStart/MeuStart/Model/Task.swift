//
//  Task.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 14/10/25.
//

import SwiftData
import Foundation

@Model
final class TaskItem {
    var id: UUID
    var title: String
    var isDone: Bool
    var details: String?
    var employee: Employee?

    init(
        id: UUID = UUID(),
        title: String,
        isDone: Bool = false,
        details: String? = nil,
        employee: Employee? = nil
    ) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.details = details
        self.employee = employee
    }
}

//import Foundation
//import SwiftData
//
//@Model
//final class TaskItem {
//    var title: String
//    var description: String
//    var isDone: Bool
//    var employee: Employee?
//
//    init(title: String, description: String, isDone: Bool = false, employee: Employee? = nil) {
//        self.title = title
//        self.description = description
//        self.isDone = isDone
//        self.employee = employee
//    }
//}
