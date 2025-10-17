//
//  SubTask.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
//
//  Subtask.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import SwiftData
import Foundation

@Model
final class Subtask {
    var id: UUID
    var title: String
    var isDone: Bool
    var details: String? // 👈 NOVO CAMPO (descrição opcional)

    // 🔹 Relações
    @Relationship(deleteRule: .nullify)
    var parentTask: TaskItem?

    @Relationship(deleteRule: .nullify)
    var parentTemplate: TaskTemplate?

    init(
        id: UUID = UUID(),
        title: String,
        isDone: Bool = false,
        details: String? = nil, // 👈 NOVO PARAMETRO
        parentTask: TaskItem? = nil,
        parentTemplate: TaskTemplate? = nil
    ) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.details = details
        self.parentTask = parentTask
        self.parentTemplate = parentTemplate
    }
}
