//import SwiftUI
//
//// MARK: - Lista de tarefas (raiz)
//struct ChecklistView: View {
//    @State private var items: [ChecklistItem] = [
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
//
//    var body: some View {
//        NavigationStack {
//            List {
//                Section {
//                    ForEach(items) { item in
//                        NavigationLink(value: item) {
//                            HStack(spacing: 12) {
//                                CheckCircle(isOn: item.isDone)
//                                Text(item.title)
//                                    .strikethrough(item.isDone, color: .primary)
//                                    .foregroundStyle(.primary)
//                                
//                            }
//                            .padding(.vertical, 6)
//                        }
//                    }
//                } header: {
//                    Text("Tarefas:").font(.title3.bold())
//                }
//            }
//            .listStyle(.insetGrouped)
//            .navigationTitle("Onboarding")
//            .navigationDestination(for: ChecklistItem.self) { item in
//                if let idx = items.firstIndex(where: { $0.id == item.id }) {
//                    TaskDetailView(item: $items[idx])
//                } else {
//                    TaskDetailView(item: .constant(item))
//                }
//            }
//        }
//    }
//}
//


struct CheckCircle: View {
    var isOn: Bool
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(isOn ? Color.green : Color.secondary, lineWidth: 2)
                .frame(width: 22, height: 22)
            if isOn {
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.green)
            }
        }
        .accessibilityLabel(isOn ? "Concluída" : "Não concluída")
    }
}

import SwiftUI

struct ChecklistView: View {
    @State private var items: [ChecklistItem] = [
        .init(title: "Assinar o Contrato", isDone: true, details: .init(markdown: sampleMarkdown)),
        .init(title: "Ler o manual de cultura", details: .init(markdown: sampleMarkdown)),
        .init(title: "Configurar e-mail", details: .init(markdown: sampleMarkdown)),
        .init(title: "Pedir crachá de acesso", details: .init(markdown: sampleMarkdown)),
        .init(title: "Conhecer sua equipe", details: .init(markdown: sampleMarkdown))
    ]

    var body: some View {
        NavigationStack {
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
                } header: {
                    Text("Tarefas:").font(.title3.bold())
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Onboarding")
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

#Preview {
    ChecklistView()
}
