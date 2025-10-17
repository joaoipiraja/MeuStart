//
//  ChecklistDynamicView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
import SwiftUI
import SwiftData

struct ChecklistDynamicView: View {
    @ObservedObject var taskVM: TaskViewModel
    @State var task: TaskItem

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Tarefas:").font(.title3.bold())) {
                    if task.subtasks.isEmpty {
                        Text("Nenhuma subtarefa atribuída.")
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 6)
                    } else {
                        ForEach(task.subtasks) { sub in
                            NavigationLink {
                                SubtaskDetailViewDynamic(subtask: sub, task: $task, taskVM: taskVM)
                            } label: {
                                HStack(spacing: 12) {
                                    CheckCircle(isOn: sub.isDone)
                                        .onTapGesture {
                                            taskVM.toggleSubtask(sub, in: task)
                                        }
                                    Text(sub.title)
                                        .strikethrough(sub.isDone, color: .primary)
                                        .foregroundStyle(.primary)
                                }
                                .padding(.vertical, 6)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(task.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(Int(task.progress * 100))% concluído")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
//
//#Preview {
//    do {
//        // Container temporário em memória
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: [TaskItem.self, Subtask.self], configurations: config)
//        let context = ModelContext(container)
//
//        // Subtarefas fake
//        let subtasks = [
//            Subtask(title: "Assinar contrato", isDone: true),
//            Subtask(title: "Ler manual de cultura", isDone: false),
//            Subtask(title: "Configurar e-mail", isDone: false)
//        ]
//
//        // Task fake
//        let task = TaskItem(
//            title: "Onboarding - Primeiros Passos",
//            isDone: false,
//            details: "Etapas iniciais do colaborador.",
//            subtasks: subtasks
//        )
//
//        let vm = TaskViewModel(context: context)
//        return NavigationStack {
//            ChecklistDynamicView(taskVM: vm, task: task)
//        }
//    } catch {
//        return Text("❌ Erro no Preview: \(error.localizedDescription)")
//    }
//}
