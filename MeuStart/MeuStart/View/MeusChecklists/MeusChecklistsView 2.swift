//
//  MeusChecklistsView 2.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//

//
//import SwiftUI
//
//struct MeusChecklistsView: View {
//    @ObservedObject var vm: LoginViewModel   // 👈 ViewModel do login
//    @State private var checklists: [Checklist] = [
//        .init(titulo: "Onboarding - Primeiros Passos", tarefasConcluidas: 2, totalTarefas: 5),
//        .init(titulo: "Treinamento de Integração", tarefasConcluidas: 4, totalTarefas: 5)
//    ]
//    
//    var body: some View {
//        TabView {
//            NavigationStack {
//                ZStack {
//                    Color(uiColor: .systemGray6).ignoresSafeArea()
//                    
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 16) {
//                            
//                            // Cabeçalho
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text("Início")
//                                    .font(.largeTitle).bold()
//                                Text("Olá, Colaborador!")
//                                    .font(.title3).bold()
//                                    .foregroundStyle(.primary)
//                            }
//                            .padding(.top, 8)
//                            
//                            // Seção
//                            Text("Seus Checklists:")
//                                .font(.headline)
//                                .padding(.top, 8)
//                            
//                            VStack(spacing: 14) {
//                                ForEach(checklists) { item in
//                                    ChecklistCard(checklist: item) {
//                                        print("Abrir \(item.titulo)")
//                                    }
//                                }
//                            }
//                            .padding(.top, 4)
//                        }
//                        .padding(.horizontal, 20)
//                        .padding(.bottom, 24)
//                    }
//                }
//                .navigationTitle("Início")
//                .toolbar {
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button(role: .destructive) {
//                            vm.logout()
//                        } label: {
//                            Label("Sair", systemImage: "rectangle.portrait.and.arrow.right")
//                        }
//                    }
//                }
//            }
//            .tabItem {
//                Image(systemName: "house.fill")
//                Text("Início")
//            }
//            
//            // Aba Tarefas (placeholder)
//            Text("Tarefas")
//                .tabItem {
//                    Image(systemName: "checklist")
//                    Text("Tarefas")
//                }
//            
//            // Aba Configurações (placeholder)
//            Text("Configurações")
//                .tabItem {
//                    Image(systemName: "gearshape")
//                    Text("Configurações")
//                }
//        }
//        .tint(.green)
//    }
//}
//
//#Preview {
//    MeusChecklistsView(vm: LoginViewModel())
//}

import SwiftUI
import SwiftData

struct MeusChecklistsView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var vm: LoginViewModel
    @StateObject private var taskVM: TaskViewModel
    @State private var checklists: [Checklist] = []

    // MARK: - Inicializador
    init(vm: LoginViewModel) {
        self._vm = ObservedObject(initialValue: vm)
        // ⚙️ Inicializa com um placeholder, mas o contexto real será injetado no .onAppear
        self._taskVM = StateObject(wrappedValue: TaskViewModel(context: ModelContext(try! ModelContainer(for: User.self, TaskItem.self, Subtask.self))))
    }

    var body: some View {
        TabView {
            // MARK: - Aba Início
            NavigationStack {
                ZStack {
                    Color(uiColor: .systemGray6).ignoresSafeArea()

                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Cabeçalho
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Início")
                                    .font(.largeTitle).bold()
                                if let user = vm.loggedUser {
                                    Text("Olá, \(user.name)!")
                                        .font(.title3).bold()
                                        .foregroundStyle(.primary)
                                }
                            }
                            .padding(.top, 8)

                            // Seção
                            Text("Seus Checklists:")
                                .font(.headline)
                                .padding(.top, 8)

                            if checklists.isEmpty {
                                Text("Nenhuma tarefa atribuída ainda.")
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 16)
                            } else {
                                VStack(spacing: 14) {
                                    VStack(spacing: 14) {
                                        ForEach(checklists) { item in
                                            // Quebramos a lógica em duas partes para aliviar o compilador
                                            let taskMatch = taskVM.tasks.first(where: { $0.title == item.titulo })
                                            
                                            if let task = taskMatch {
                                                NavigationLink(destination: ChecklistDynamicView(taskVM: taskVM, task: task)) {
                                                    ChecklistCard(checklist: item) { }
                                                }
                                            } else {
                                                ChecklistCard(checklist: item) { }
                                                    .opacity(0.4)
                                            }
                                        }
                                    }
                                    .padding(.top, 4)

                                }
                                .padding(.top, 4)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                }
                .navigationTitle("Início")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(role: .destructive) {
                            vm.logout()
                        } label: {
                            Label("Sair", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                    }
                }
                .onAppear {
                    // ✅ Usa o contexto real do ambiente
                    taskVM.setContext(context)

                    if let user = vm.loggedUser {
                        taskVM.fetchTasks(for: user)
                        checklists = taskVM.makeChecklist(for: user)
                    }
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Início")
            }

            // MARK: - Aba Tarefas
            NavigationStack {
                List {
                    ForEach(taskVM.tasks) { task in
                        NavigationLink(destination: TaskDetailViewDynamic(task: task, taskVM: taskVM)) {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                Text("\(Int(task.progress * 100))% concluído")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .navigationTitle("Minhas Tarefas")
                .onAppear {
                    if let user = vm.loggedUser {
                        taskVM.fetchTasks(for: user)
                    }
                }
            }
            .tabItem {
                Image(systemName: "checklist")
                Text("Tarefas")
            }

            // MARK: - Aba Configurações
            Text("Configurações em breve...")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Configurações")
                }
        }
        .tint(.green)
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    var body: some View {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: User.self, TaskItem.self, Subtask.self, configurations: config)
            let context = ModelContext(container)

            // Usuário fake
            let user = User(name: "João Vitor", email: "joao@empresa.com", password: "123", role: "Dev iOS")

            // Subtarefas fake
            let subtasks = [
                Subtask(title: "Etapa 1", isDone: true),
                Subtask(title: "Etapa 2", isDone: false)
            ]

            // Tarefa fake
            let task = TaskItem(
                title: "Onboarding - Primeiros Passos",
                isDone: false,
                details: "Primeira etapa de integração",
                user: user,
                subtasks: subtasks
            )

            context.insert(user)
            context.insert(task)
            try context.save()

            let loginVM = LoginViewModel()
            loginVM.loggedUser = user

            return AnyView(
                MeusChecklistsView(vm: loginVM)
                    .modelContainer(container)
            )
        } catch {
            return AnyView(Text("❌ Erro no preview: \(error.localizedDescription)"))
        }
    }
}
