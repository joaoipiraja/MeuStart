////
////  TaskManagerView.swift
////  MeuStart
////
////  Created by João Vitor Alves Holanda on 17/10/25.
////
////
////
//
//import SwiftUI
//import SwiftData
//
//struct TaskManagerView: View {
//    @Environment(\.modelContext) private var context
//
//    // MARK: - Dados persistidos
//    @State private var templates: [TaskTemplate] = []
//    @State private var users: [User] = []
//
//    // MARK: - Campos de criação
//    @State private var newTitle = ""
//    @State private var newDetails = ""
//
//    // MARK: - Seleção
//    @State private var selectedTemplate: TaskTemplate?
//    @State private var selectedUsers = Set<PersistentIdentifier>()
//
//    // MARK: - Feedback
//    @State private var showingResult = false
//    @State private var resultMessage = ""
//    @State private var resultIsError = false
//
//    var body: some View {
//        NavigationStack {
//            List {
//                createTemplateSection
//                templateListSection
//                usersSection
//                assignSection
//            }
//            .navigationTitle("Gerenciar Tarefas")
//            .alert(isPresented: $showingResult) {
//                Alert(
//                    title: Text(resultIsError ? "Erro" : "Sucesso"),
//                    message: Text(resultMessage),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//            .onAppear { loadData() }
//        }
//    }
//
//    // MARK: - Seções
//
//    private var createTemplateSection: some View {
//        Section(header: Text("Criar novo modelo de tarefa")) {
//            TextField("Título do modelo", text: $newTitle)
//            TextField("Detalhes (Markdown opcional)", text: $newDetails, axis: .vertical)
//                .lineLimit(3...6)
//
//            Button {
//                addTemplate()
//            } label: {
//                Label("Salvar modelo", systemImage: "square.and.arrow.down")
//            }
//            .disabled(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
//        }
//    }
//
//    private var templateListSection: some View {
//        Section(header: Text("Modelos existentes")) {
//            if templates.isEmpty {
//                Text("Nenhum modelo criado ainda.")
//                    .foregroundStyle(.secondary)
//            } else {
//                ForEach(templates) { template in
//                    HStack {
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text(template.title).font(.headline)
//                            if let d = template.details, !d.isEmpty {
//                                Text(d)
//                                    .font(.subheadline)
//                                    .foregroundStyle(.secondary)
//                                    .lineLimit(2)
//                            }
//                        }
//                        Spacer()
//                        if selectedTemplate?.id == template.id {
//                            Image(systemName: "checkmark.circle.fill")
//                                .foregroundStyle(.green)
//                        }
//                    }
//                    .contentShape(Rectangle())
//                    .onTapGesture { selectedTemplate = template }
//                }
//            }
//        }
//    }
//
//    private var usersSection: some View {
//        Section(header: Text("Selecionar colaboradores")) {
//            let collaborators = users.filter { !$0.isAdmin }
//
//            if collaborators.isEmpty {
//                Text("Nenhum colaborador cadastrado.")
//                    .foregroundStyle(.secondary)
//            } else {
//                ForEach(collaborators) { user in
//                    let isSelected = selectedUsers.contains(user.persistentModelID)
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(user.name)
//                            Text(user.role)
//                                .font(.caption)
//                                .foregroundStyle(.secondary)
//                        }
//                        Spacer()
//                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
//                            .foregroundStyle(isSelected ? .green : .secondary)
//                    }
//                    .contentShape(Rectangle())
//                    .onTapGesture { toggle(user) }
//                }
//            }
//        }
//    }
//
//    private var assignSection: some View {
//        Section {
//            Button {
//                assignSelected()
//            } label: {
//                Label("Atribuir tarefa aos selecionados", systemImage: "paperplane.fill")
//            }
//            .disabled(selectedTemplate == nil || selectedUsers.isEmpty)
//        }
//    }
//
//    // MARK: - Funções principais
//
//    private func loadData() {
//        do {
//            templates = try context.fetch(FetchDescriptor<TaskTemplate>(sortBy: [SortDescriptor(\.title)]))
//            users = try context.fetch(FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)]))
//            print("📦 Modelos: \(templates.map { $0.title })")
//            print("👥 Usuários carregados: \(users.map { $0.name })")
//        } catch {
//            print("❌ Erro ao carregar dados: \(error)")
//        }
//    }
//
//    private func addTemplate() {
//        let trimmed = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !trimmed.isEmpty else { return }
//
//        let template = TaskTemplate(title: trimmed, details: newDetails.isEmpty ? nil : newDetails)
//        context.insert(template)
//
//        do {
//            try context.save()
//            newTitle = ""
//            newDetails = ""
//            result("Modelo criado com sucesso.", error: false)
//            loadData()
//        } catch {
//            result("Erro ao salvar modelo: \(error.localizedDescription)", error: true)
//        }
//    }
//
//    private func toggle(_ user: User) {
//        let id = user.persistentModelID
//        if selectedUsers.contains(id) {
//            selectedUsers.remove(id)
//        } else {
//            selectedUsers.insert(id)
//        }
//    }
//
//    private func assignSelected() {
//        guard let template = selectedTemplate else {
//            result("Selecione um modelo primeiro.", error: true)
//            return
//        }
//
//        let chosen = users.filter { selectedUsers.contains($0.persistentModelID) }
//        guard !chosen.isEmpty else {
//            result("Selecione ao menos um colaborador.", error: true)
//            return
//        }
//
//        var created = 0
//        for user in chosen {
//            let task = TaskItem(
//                title: template.title,
//                isDone: false, details: template.details,
//                user: user
//            )
//            context.insert(task)
//            created += 1
//        }
//
//        do {
//            try context.save()
//            result("✅ \(created) tarefa(s) atribuída(s) com sucesso.", error: false)
//            selectedUsers.removeAll()
//        } catch {
//            result("Erro ao atribuir tarefas: \(error.localizedDescription)", error: true)
//        }
//    }
//
//    private func result(_ message: String, error: Bool) {
//        resultMessage = message
//        resultIsError = error
//        showingResult = true
//        print(error ? "❌ \(message)" : "✅ \(message)")
//    }
//}
//
//#Preview {
//    TaskManagerView()
//        .modelContainer(for: [User.self, TaskTemplate.self, TaskItem.self])
//}
//
//  TaskManagerView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
//
//  TaskManagerView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//
import SwiftUI
import SwiftData

// MARK: - Modelo temporário para subtarefas
private struct SubtaskDraft: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var details: String
}

struct TaskManagerView: View {
    @Environment(\.modelContext) private var context

    // MARK: - Dados persistidos
    @State private var templates: [TaskTemplate] = []
    @State private var users: [User] = []

    // MARK: - Campos de criação
    @State private var newTitle = ""
    @State private var newDetails = ""
    @State private var subtasks: [SubtaskDraft] = [SubtaskDraft(title: "", details: "")]

    // MARK: - Seleção
    @State private var selectedTemplate: TaskTemplate?
    @State private var selectedUsers = Set<PersistentIdentifier>()

    // MARK: - Feedback
    @State private var showingResult = false
    @State private var resultMessage = ""
    @State private var resultIsError = false

    var body: some View {
        NavigationStack {
            List {
                createTemplateSection
                templateListSection
                usersSection
                assignSection
            }
            .navigationTitle("Gerenciar Tarefas")
            .alert(isPresented: $showingResult) {
                Alert(
                    title: Text(resultIsError ? "Erro" : "Sucesso"),
                    message: Text(resultMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear { loadData() }
        }
    }

    // MARK: - Criar modelo
    private var createTemplateSection: some View {
        Section(header: Text("Criar novo modelo de tarefa")) {
            TextField("Título do modelo", text: $newTitle)
            TextField("Detalhes gerais (Markdown opcional)", text: $newDetails, axis: .vertical)
                .lineLimit(3...6)

            VStack(alignment: .leading, spacing: 8) {
                Text("Subtarefas:")
                    .font(.headline)
                    .padding(.top, 6)

                // 🔹 iteração sobre uma cópia estável
                ForEach(Array(subtasks.enumerated()), id: \.element.id) { index, sub in
                    SubtaskInputRow(
                        index: index,
                        title: Binding(
                            get: { subtasks[index].title },
                            set: { subtasks[index].title = $0 }
                        ),
                        details: Binding(
                            get: { subtasks[index].details },
                            set: { subtasks[index].details = $0 }
                        ),
                        canRemove: subtasks.count > 1,
                        onRemove: {
                            removeSubtask(at: index)
                        }
                    )
                }

                Button {
                    withAnimation {
                        subtasks.append(SubtaskDraft(title: "", details: ""))
                    }
                } label: {
                    Label("Adicionar Subtarefa", systemImage: "plus.circle")
                }
                .font(.callout)
                .padding(.top, 4)
            }
            .padding(.vertical, 4)

            Button {
                addTemplate()
            } label: {
                Label("Salvar modelo", systemImage: "square.and.arrow.down")
            }
            .disabled(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }

    // 🔹 Função de remoção segura
    private func removeSubtask(at index: Int) {
        guard index >= 0 && index < subtasks.count else { return }
        withAnimation {
            subtasks.remove(at: index)
        }
    }

    // MARK: - Modelos existentes
    private var templateListSection: some View {
        Section(header: Text("Modelos existentes")) {
            if templates.isEmpty {
                Text("Nenhum modelo criado ainda.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(templates) { template in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(template.title)
                                    .font(.headline)

                                if let d = template.details, !d.isEmpty {
                                    Text(d)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)
                                }

                                if !template.subtasks.isEmpty {
                                    Text("\(template.subtasks.count) subtarefa(s)")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }

                            Spacer()

                            if selectedTemplate?.id == template.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }

                        if !template.subtasks.isEmpty {
                            VStack(alignment: .leading, spacing: 2) {
                                ForEach(template.subtasks) { sub in
                                    HStack(spacing: 6) {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 6))
                                            .foregroundColor(.secondary)
                                        Text(sub.title)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding(.top, 2)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { selectedTemplate = template }
                }
            }
        }
    }

    // MARK: - Seleção de usuários
    private var usersSection: some View {
        Section(header: Text("Selecionar colaboradores")) {
            let collaborators = users.filter { !$0.isAdmin }

            if collaborators.isEmpty {
                Text("Nenhum colaborador cadastrado.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(collaborators) { user in
                    let isSelected = selectedUsers.contains(user.persistentModelID)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)
                            Text(user.role)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(isSelected ? .green : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { toggle(user) }
                }
            }
        }
    }

    // MARK: - Atribuir tarefas
    private var assignSection: some View {
        Section {
            Button {
                assignSelected()
            } label: {
                Label("Atribuir tarefa aos selecionados", systemImage: "paperplane.fill")
            }
            .disabled(selectedTemplate == nil || selectedUsers.isEmpty)
        }
    }

    // MARK: - Lógica
    private func loadData() {
        do {
            templates = try context.fetch(FetchDescriptor<TaskTemplate>(sortBy: [SortDescriptor(\.title)]))
            users = try context.fetch(FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)]))
        } catch {
            print("❌ Erro ao carregar dados: \(error)")
        }
    }

    private func addTemplate() {
        let trimmed = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let template = TaskTemplate(title: trimmed, details: newDetails.isEmpty ? nil : newDetails)
        context.insert(template)

        for sub in subtasks where !sub.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let subtask = Subtask(
                title: sub.title,
                isDone: false,
                details: sub.details,
                parentTemplate: template
            )
            context.insert(subtask)
        }

        do {
            try context.save()
            newTitle = ""
            newDetails = ""
            subtasks = [SubtaskDraft(title: "", details: "")]
            result("Modelo criado com sucesso.", error: false)
            loadData()
        } catch {
            result("Erro ao salvar modelo: \(error.localizedDescription)", error: true)
        }
    }

    private func toggle(_ user: User) {
        let id = user.persistentModelID
        if selectedUsers.contains(id) {
            selectedUsers.remove(id)
        } else {
            selectedUsers.insert(id)
        }
    }

    private func assignSelected() {
        guard let template = selectedTemplate else {
            result("Selecione um modelo primeiro.", error: true)
            return
        }

        let chosen = users.filter { selectedUsers.contains($0.persistentModelID) }
        guard !chosen.isEmpty else {
            result("Selecione ao menos um colaborador.", error: true)
            return
        }

        var created = 0
        for user in chosen {
            let task = TaskItem(
                title: template.title,
                isDone: false,
                details: template.details,
                user: user
            )

            for sub in template.subtasks {
                let newSub = Subtask(
                    title: sub.title,
                    isDone: false,
                    details: sub.details,
                    parentTask: task
                )
                context.insert(newSub)
            }

            context.insert(task)
            created += 1
        }

        do {
            try context.save()
            result("✅ \(created) tarefa(s) atribuída(s) com sucesso.", error: false)
            selectedUsers.removeAll()
        } catch {
            result("Erro ao atribuir tarefas: \(error.localizedDescription)", error: true)
        }
    }

    private func result(_ message: String, error: Bool) {
        resultMessage = message
        resultIsError = error
        showingResult = true
        print(error ? "❌ \(message)" : "✅ \(message)")
    }
}

// MARK: - Subview: Linha de subtarefa
private struct SubtaskInputRow: View {
    let index: Int
    @Binding var title: String
    @Binding var details: String
    var canRemove: Bool
    var onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                TextField("Título da subtarefa \(index + 1)", text: $title)
                    .textFieldStyle(.roundedBorder)
                if canRemove {
                    Button(role: .destructive) {
                        onRemove()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }

            TextField("Descrição (opcional)", text: $details, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...3)
                .font(.caption)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TaskManagerView()
        .modelContainer(for: [User.self, TaskTemplate.self, TaskItem.self, Subtask.self])
}
