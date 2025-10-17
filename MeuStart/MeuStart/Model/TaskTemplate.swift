//
//  TaskTemplate.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
// TaskTemplate.swift
import SwiftData
import Foundation

@Model
final class TaskTemplate {
    var id: UUID
    var title: String
    var details: String?

    // 🔹 Relação inversa com Subtask
    @Relationship(deleteRule: .cascade, inverse: \Subtask.parentTemplate)
    var subtasks: [Subtask] = [] // 👈 NOVO

    // 🔹 Relação com TaskItem (já existia antes)
    @Relationship(deleteRule: .cascade, inverse: \TaskItem.template)
    var taskInstances: [TaskItem] = []

    init(id: UUID = UUID(), title: String, details: String? = nil) {
        self.id = id
        self.title = title
        self.details = details
    }
}


