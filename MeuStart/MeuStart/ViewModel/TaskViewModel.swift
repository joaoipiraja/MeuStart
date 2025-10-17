//
//  TaskViewModel.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
//
//  TaskViewModel.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
import SwiftData
import Foundation

@MainActor
final class TaskViewModel: ObservableObject {
    // MARK: - Dados observáveis
    @Published private(set) var tasks: [TaskItem] = []

    // MARK: - Contexto SwiftData
    private var context: ModelContext

    // MARK: - Inicialização
    init(context: ModelContext) {
        self.context = context
    }

    // Permite atualizar o contexto após login ou mudança de container
    func setContext(_ newContext: ModelContext) {
        self.context = newContext
    }

    // MARK: - Buscar tarefas do usuário logado
    func fetchTasks(for user: User) {
        do {
            // Busca todas as tarefas e filtra em memória
            let allTasks = try context.fetch(
                FetchDescriptor<TaskItem>(sortBy: [SortDescriptor(\.title)])
            )
            tasks = allTasks.filter { $0.user?.email == user.email }
            print("📋 \(tasks.count) tarefa(s) carregada(s) para \(user.name)")
        } catch {
            print("❌ Erro ao buscar tarefas: \(error.localizedDescription)")
        }
    }


    // MARK: - Criar nova tarefa
    func addTask(title: String, details: String?, for user: User?) {
        let task = TaskItem(title: title, isDone: false, details: details, user: user)
        context.insert(task)
        saveChanges()
        tasks.append(task)
    }

    // MARK: - Marcar como concluída
    func toggleDone(_ task: TaskItem) {
        task.isDone.toggle()
        saveChanges()
    }

    // MARK: - Excluir tarefa
    func deleteTask(_ task: TaskItem) {
        context.delete(task)
        tasks.removeAll { $0.id == task.id }
        saveChanges()
    }

    // MARK: - Subtarefas
    func addSubtask(to task: TaskItem, title: String) {
        let sub = Subtask(title: title, isDone: false, parentTask: task)
        task.subtasks.append(sub)
        saveChanges()
    }

    func toggleSubtask(_ subtask: Subtask, in task: TaskItem) {
        guard let index = task.subtasks.firstIndex(where: { $0.id == subtask.id }) else { return }
        task.subtasks[index].isDone.toggle()

        // Atualiza o status geral da task
        task.isDone = task.subtasks.allSatisfy { $0.isDone }
        saveChanges()
        print("🔁 Subtarefa '\(subtask.title)' atualizada (\(subtask.isDone ? "concluída" : "pendente"))")
    }

    // MARK: - Criar checklists visuais
    func makeChecklist(for user: User) -> [Checklist] {
        // Retorna uma lista com um item por tarefa
        tasks
            .filter { $0.user?.email == user.email }
            .map { task in
                Checklist(
                    titulo: task.title,
                    tarefasConcluidas: task.subtasks.filter(\.isDone).count,
                    totalTarefas: task.subtasks.count
                )
            }
    }

    // MARK: - Persistência
    private func saveChanges() {
        do {
            try context.save()
            print("💾 Alterações salvas com sucesso.")
        } catch {
            print("❌ Erro ao salvar alterações: \(error.localizedDescription)")
        }
    }
}
