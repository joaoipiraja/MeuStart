//
//  TaskDetailViewDynamic.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

//
//import SwiftUI
//import SwiftData
//
//struct TaskDetailViewDynamic: View {
//    @ObservedObject var taskVM: TaskViewModel
//    @Environment(\.openURL) private var openURL
//    @Environment(\.dismiss) private var dismiss
//    @State private var isDone: Bool
//    let task: TaskItem
//
//    init(task: TaskItem, taskVM: TaskViewModel) {
//        self.task = task
//        self._isDone = State(initialValue: task.isDone)
//        self._taskVM = ObservedObject(initialValue: taskVM)
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                // Cabeçalho
//                HStack(alignment: .top, spacing: 12) {
//                    CheckCircle(isOn: isDone)
//                        .onTapGesture { toggleDone() }
//
//                    Text(task.title)
//                        .font(.title3.weight(.semibold))
//                        .foregroundStyle(.primary)
//                        .fixedSize(horizontal: false, vertical: true)
//                }
//
//                // Detalhes
//                if let details = task.details, !details.isEmpty {
//                    Text(.init(details))
//                        .font(.body)
//                        .foregroundStyle(.primary)
//                }
//
//                // Link automático
//                if let details = task.details,
//                   let url = extractFirstURL(from: details) {
//                    Button {
//                        openURL(url)
//                    } label: {
//                        HStack {
//                            Spacer()
//                            Text("Abrir link relacionado")
//                                .fontWeight(.semibold)
//                            Image(systemName: "arrow.up.right.square")
//                            Spacer()
//                        }
//                        .padding(.vertical, 14)
//                        .padding(.horizontal, 16)
//                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.green))
//                        .foregroundStyle(.white)
//                    }
//                    .buttonStyle(.plain)
//                    .padding(.top, 6)
//                }
//            }
//            .padding(16)
//        }
//        .navigationTitle("Tarefa")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(isDone ? "Desfazer" : "Concluir") {
//                    toggleDone()
//                }
//            }
//        }
//    }
//
//    // MARK: - Funções auxiliares
//    private func toggleDone() {
//        isDone.toggle()
//        task.isDone = isDone
//        taskVM.toggleDone(task)
//    }
//
//    private func extractFirstURL(from text: String) -> URL? {
//        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        let matches = detector?.matches(in: text, range: NSRange(text.startIndex..., in: text))
//        guard let match = matches?.first, let range = Range(match.range, in: text) else { return nil }
//        return URL(string: String(text[range]))
//    }
//}
//
//#Preview {
//    // Preview isolado com dados fictícios
//    let container = try! ModelContainer(for: TaskItem.self)
//    let context = ModelContext(container)
//    let taskVM = TaskViewModel(context: context)
//    let exampleTask = TaskItem(title: "Ler Manual da Empresa", details: "Acesse https://empresa.com/manual")
//    return NavigationStack {
//        TaskDetailViewDynamic(task: exampleTask, taskVM: taskVM)
//    }
//}

import SwiftUI
import SwiftData

struct TaskDetailViewDynamic: View {
    @ObservedObject var taskVM: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var task: TaskItem

    init(task: TaskItem, taskVM: TaskViewModel) {
        self._task = State(initialValue: task)
        self._taskVM = ObservedObject(initialValue: taskVM)
    }

    var body: some View {
        List {
            // 🔹 Detalhes da tarefa
            Section("Detalhes") {
                Text(task.details ?? "Sem descrição")
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            // 🔹 Subtarefas
            Section("Subtarefas") {
                if task.subtasks.isEmpty {
                    Text("Nenhuma subtarefa adicionada.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(task.subtasks) { sub in
                        HStack {
                            Image(systemName: sub.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(sub.isDone ? .green : .gray)
                                .onTapGesture {
                                    taskVM.toggleSubtask(sub, in: task)
                                }
                            Text(sub.title)
                                .strikethrough(sub.isDone, color: .primary)
                                .foregroundStyle(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle(task.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Progresso: \(Int(task.progress * 100))%")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
    }
}

