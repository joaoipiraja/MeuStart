//
//  Task.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 14/10/25.
//
//
//import SwiftData
//import Foundation
//
//@Model
//final class TaskItem {
//    var id: UUID
//    var title: String
//    var isDone: Bool
//    var details: String?
//    var employee: Employee?
//
//    init(
//        id: UUID = UUID(),
//        title: String,
//        isDone: Bool = false,
//        details: String? = nil,
//        employee: Employee? = nil
//    ) {
//        self.id = id
//        self.title = title
//        self.isDone = isDone
//        self.details = details
//        self.employee = employee
//    }
//}
import Foundation
import SwiftData
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
//
//  TaskItem.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
//
//  TaskItem.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import SwiftData
import Foundation

@Model
final class TaskItem {
    // MARK: - Propriedades
    var id: UUID
    var title: String
    var isDone: Bool
    var details: String?

    // MARK: - Relações
    @Relationship(deleteRule: .nullify)
    var user: User?

    @Relationship(deleteRule: .nullify)
    var template: TaskTemplate?

    @Relationship(deleteRule: .cascade, inverse: \Subtask.parentTask)
    var subtasks: [Subtask] = []

    // MARK: - Progresso calculado
    /// Calcula o progresso com base nas subtarefas concluídas.
    var progress: Double {
        guard !subtasks.isEmpty else { return isDone ? 1.0 : 0.0 }
        let doneCount = subtasks.filter { $0.isDone }.count
        return Double(doneCount) / Double(subtasks.count)
    }

    // MARK: - Inicializador
    init(
        id: UUID = UUID(),
        title: String,
        isDone: Bool = false,
        details: String? = nil,
        user: User? = nil,
        template: TaskTemplate? = nil,
        subtasks: [Subtask] = []
    ) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.details = details
        self.user = user
        self.template = template
        self.subtasks = subtasks
    }
}
