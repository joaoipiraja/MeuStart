//
//  SubtaskDetailViewDynamic.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import SwiftUI

struct SubtaskDetailViewDynamic: View {
    let subtask: Subtask
    @Binding var task: TaskItem
    @ObservedObject var taskVM: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 12) {
                    CheckCircle(isOn: subtask.isDone)
                        .onTapGesture {
                            taskVM.toggleSubtask(subtask, in: task)
                        }
                    Text(subtask.title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.primary)
                }
                
                if let details = subtask.details, !details.isEmpty {
                    Text(details)
                        .font(.body)
                        .foregroundStyle(.primary)
                }
            }
            .padding(16)
        }
        .navigationTitle("Tarefa")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    let subt = Subtask(title: "Ler manual da empresa", isDone: false)
//    let task = Binding.constant(TaskItem(title: "Onboarding", subtasks: [subt]))
//    let vm = TaskViewModel(context: try! ModelContext(ModelContainer(for: TaskItem.self, Subtask.self)))
//    return NavigationStack {
//        SubtaskDetailViewDynamic(subtask: subt, task: task, taskVM: vm)
//    }
//}
