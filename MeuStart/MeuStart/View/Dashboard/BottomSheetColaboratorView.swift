//
//  BottomSheet.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//

import SwiftUI

//struct BottomSheetColaboratorView: View {
//    let employee: Employee
//    @Binding var showSheet: Bool
//    @State private var itemsOnboard: [ChecklistItem] = [
//        .init(
//            title: "Assinar o Contrato",
//            isDone: true,
//            details: .init(
//                markdown: sampleMarkdown,
//                actionTitle: "Acessar contrato",
//                actionURL: URL(string: "https://exemplo.com/contrato")
//            )
//        ),
//        .init(
//            title: "Ler o manual de cultura",
//            details: .init(
//                markdown: sampleMarkdown,
//                actionTitle: "Acessar manual de cultura",
//                actionURL: URL(string: "https://exemplo.com/manual")
//            )
//        ),
//        .init(title: "Configurar e-mail", details: .init(markdown: sampleMarkdown)),
//        .init(title: "Pedir crachá de acesso", details: .init(markdown: sampleMarkdown)),
//        .init(title: "Conhecer sua equipe", details: .init(markdown: sampleMarkdown))
//    ]
//    @State private var itemsIntegration: [ChecklistItem] = [
//        .init(
//            title: "Configurar conta no Teams",
//            isDone: true,
//            details: .init(
//                markdown: sampleMarkdown,
//                actionTitle: "Acessar contrato",
//                actionURL: URL(string: "https://exemplo.com/contrato")
//            )
//        ),
//        .init(
//            title: "Ler o manual de cultura",
//            details: .init(
//                markdown: sampleMarkdown,
//                actionTitle: "Acessar manual de cultura",
//                actionURL: URL(string: "https://exemplo.com/manual")
//            )
//        ),
//        .init(title: "Conhecer sua equipe", details: .init(markdown: sampleMarkdown))
//    ]
//    
//    var statusColor: Color {
//        switch employee.status {
//        case .completed: return .green
//        case .delayed: return .red
//        case .atention: return .yellow
//        }
//    }
//    
//    var statusLabel: String {
//        switch employee.status {
//        case .completed: return "Concluído"
//        case .delayed: return "Atrasado"
//        case .atention: return "Atenção"
//        }
//    }
//    var body: some View {
//        NavigationStack{
//        
//                VStack(alignment: .leading, spacing: 8) {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text(employee.name)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .padding(.top, 20)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        Text(statusLabel)
//                            .textCase(.uppercase)
//                            .font(.caption2)
//                            .fontWeight(.light)
//                            .padding(.vertical, 4)
//                            .padding(.horizontal, 8)
//                            .background(statusColor.opacity(0.7))
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                        
//                            HStack{
//                                Text("CARGO:")
//                                    .font(.caption)
//                                    .fontWeight(.semibold)
//                                Text(employee.role)
//                                    .font(.caption)
//                            }
//                            HStack{
//                                Text("GESTOR:")
//                                    .font(.caption)
//                                    .fontWeight(.semibold)
//                                Text(employee.manager ?? "")
//                                    .font(.caption)
//                            }
//                            HStack{
//                                Text("DATA DE INÍCIO:")
//                                    .font(.caption)
//                                    .fontWeight(.semibold)
//                                Text(employee.startDate ?? .date)
//                                    .font(.caption)
//                            }
//                    }.background(Color(red: 0.95, green: 0.95, blue: 0.97))
//                    .padding(.horizontal)
//                    Text("Checklist de Onboarding")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.vertical, 12)
//                        .padding(.horizontal)
//                    List {
//                        Section {
//                            ForEach(itemsOnboard) { item in
//                                NavigationLink(value: item) {
//                                    HStack(spacing: 12) {
//                                        CheckCircle(isOn: item.isDone)
//                                        Text(item.title)
//                                            .strikethrough(item.isDone, color: .primary)
//                                            .foregroundStyle(.primary)
//                                        
//                                    }
//                                    .padding(.vertical, 6)
//                                }
//                            }
//                        }
//                    }
//                    .scrollContentBackground(.hidden)
//                    .listRowInsets(EdgeInsets())
//                    .padding(.top, -42)
//                    .listStyle(.insetGrouped)
////                    .navigationDestination(for: ChecklistItem.self) { item in
////                        if let idx = itemsOnboard.firstIndex(where: { $0.id == item.id }) {
////                            TaskDetailView(item: $itemsOnboard[idx])
////                        } else {
////                            TaskDetailView(item: .constant(item))
////                        }
////                    }
//                    .navigationDestination(for: ChecklistItem.self) { item in
//                        if let idx = itemsOnboard.firstIndex(where: { $0.id == item.id }) {
//                            TaskDetailView(item: $itemsOnboard[idx])
//                        }
//                    }
//                    
//                    Text("Checklist de Integração")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.vertical, 12)
//                        .padding(.horizontal)
//                    List {
//                        Section {
//                            ForEach(itemsIntegration) { item in
//                                NavigationLink(value: item) {
//                                    HStack(spacing: 12) {
//                                        CheckCircle(isOn: item.isDone)
//                                        Text(item.title)
//                                            .strikethrough(item.isDone, color: .primary)
//                                            .foregroundStyle(.primary)
//                                        
//                                    }
//                                    .padding(.vertical, 6)
//                                }
//                            }
//                        }
//                    }
//                    .scrollContentBackground(.hidden)
//                    .padding(.top, -42)
//                    .listStyle(.insetGrouped)
//                    .navigationDestination(for: ChecklistItem.self) { item in
//                        if let idx = itemsIntegration.firstIndex(where: { $0.id == item.id }) {
//                            TaskDetailView(item: $itemsIntegration[idx])
//                        } else {
//                            TaskDetailView(item: .constant(item))
//                        }
//                    }
//                    
//                }
//                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
//                .toolbarBackground(Color.white, for: .navigationBar)
//                .toolbarBackground(.visible, for: .navigationBar)
//                .navigationTitle("Ficha do Colaborador")
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: {
//                            showSheet = false
//                        }) {
//                            HStack {
//                                Text("Voltar")
//                            }
//                        }
//                    }
//                }
//        }
//    }
//}
//
//#Preview {
//    @Previewable @State var showSheet2 = true
//    let employeeEx = Employee(
//        name: "João Vitor",
//        role: "Product Designer",
//        manager: "Maria Souza",
//        status: .completed,
//        startDate: .now
//    )
//    BottomSheetColaboratorView(employee: employeeEx, showSheet: $showSheet2)
//}

//
//  BottomSheetColaboratorView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//

//
//  BottomSheetColaboratorView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import SwiftUI

struct BottomSheetColaboratorView: View {
    let user: User
    @Binding var showSheet: Bool

    // MARK: - Checklist fake data
    @State private var itemsOnboard: [ChecklistItem] = [
        .init(
            title: "Assinar o Contrato",
            isDone: true,
            details: .init(
                markdown: sampleMarkdown,
                actionTitle: "Acessar contrato",
                actionURL: URL(string: "https://exemplo.com/contrato")
            )
        ),
        .init(
            title: "Ler o manual de cultura",
            details: .init(
                markdown: sampleMarkdown,
                actionTitle: "Acessar manual de cultura",
                actionURL: URL(string: "https://exemplo.com/manual")
            )
        ),
        .init(title: "Configurar e-mail", details: .init(markdown: sampleMarkdown)),
        .init(title: "Pedir crachá de acesso", details: .init(markdown: sampleMarkdown)),
        .init(title: "Conhecer sua equipe", details: .init(markdown: sampleMarkdown))
    ]

    @State private var itemsIntegration: [ChecklistItem] = [
        .init(
            title: "Configurar conta no Teams",
            isDone: true,
            details: .init(
                markdown: sampleMarkdown,
                actionTitle: "Acessar Teams",
                actionURL: URL(string: "https://exemplo.com/teams")
            )
        ),
        .init(
            title: "Ler o manual de cultura",
            details: .init(
                markdown: sampleMarkdown,
                actionTitle: "Acessar manual de cultura",
                actionURL: URL(string: "https://exemplo.com/manual")
            )
        ),
        .init(title: "Conhecer sua equipe", details: .init(markdown: sampleMarkdown))
    ]

    // MARK: - Computed props
    var statusColor: Color {
        switch user.status {
        case .completed: return .green
        case .delayed: return .red
        case .atention: return .yellow
        }
    }

    var statusLabel: String {
        switch user.status {
        case .completed: return "Concluído"
        case .delayed: return "Atrasado"
        case .atention: return "Atenção"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // 🔹 Cabeçalho isolado em Subview
                    UserHeaderView(user: user, statusLabel: statusLabel, statusColor: statusColor)

                    // 🔹 Checklists
                    ChecklistSectionView(title: "Checklist de Onboarding", items: $itemsOnboard)
                    ChecklistSectionView(title: "Checklist de Integração", items: $itemsIntegration)
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle("Ficha do Colaborador")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Voltar") {
                            showSheet = false
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Subview: Cabeçalho do Usuário
private struct UserHeaderView: View {
    let user: User
    let statusLabel: String
    let statusColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(user.name)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 20)

            Text(statusLabel)
                .textCase(.uppercase)
                .font(.caption2)
                .fontWeight(.light)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(statusColor.opacity(0.7))
                .foregroundColor(.black)
                .cornerRadius(10)

            Group {
                InfoRow(title: "CARGO:", value: user.role)
                InfoRow(title: "GESTOR:", value: user.manager ?? "")
                InfoRow(title: "DATA DE INÍCIO:", value: user.formattedStartDate)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

// MARK: - Subview: Linhas de info
private struct InfoRow: View {
    let title: String
    let value: String
    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
            Text(value)
                .font(.caption)
        }
    }
}

// MARK: - Subview: Checklists
private struct ChecklistSectionView: View {
    let title: String
    @Binding var items: [ChecklistItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top, 12)

            List {
                Section {
                    ForEach(items) { item in
                        NavigationLink(value: item) {
                            HStack(spacing: 12) {
                                CheckCircle(isOn: item.isDone)
                                Text(item.title)
                                    .strikethrough(item.isDone, color: .primary)
                                    .foregroundStyle(.primary)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .navigationDestination(for: ChecklistItem.self) { item in
                if let idx = items.firstIndex(where: { $0.id == item.id }) {
                    TaskDetailView(item: $items[idx])
                } else {
                    TaskDetailView(item: .constant(item))
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var showSheet2 = true
    let userEx = User(
        name: "João Vitor",
        email: "joao@teste.com",
        password: "123",
        role: "Product Designer",
        isAdmin: false,
        manager: "Maria Souza",
        status: .completed,
        startDate: .now
    )

    BottomSheetColaboratorView(user: userEx, showSheet: $showSheet2)
}
