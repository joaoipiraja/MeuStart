import SwiftUI

// MARK: - Modelo
struct ChecklistItem: Identifiable, Hashable {
    struct Details: Equatable, Hashable {
        var markdown: String
        var actionTitle: String?
        var actionURL: URL?
    }

    let id = UUID()
    var title: String
    var isDone: Bool = false
    var details: Details
}

// MARK: - Lista de tarefas (raiz)
struct ChecklistView: View {
    @State private var items: [ChecklistItem] = [
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
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                } header: {
                    Text("Tarefas:").font(.title3.bold())
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Onboarding - Primeiros Passos")
            .navigationDestination(for: ChecklistItem.self) { item in
                if let idx = items.firstIndex(where: { $0.id == item.id }) {
                    TaskDetailView(item: $items[idx])
                } else {
                    TaskDetailView(item: .constant(item)) // Fallback
                }
            }
        }
    }
}

// MARK: - Detalhe (abre dentro da NavigationStack, não é sheet)
struct TaskDetailView: View {
    @Binding var item: ChecklistItem
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss
    @State private var localDone = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Cabeçalho com “checkbox” e título
                HStack(alignment: .top, spacing: 12) {
                    CheckCircle(isOn: localDone)
                        .onTapGesture { localDone.toggle() }
                    Text(item.title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Conteúdo em Markdown
                Text(.init(item.details.markdown))
                    .font(.body)
                    .foregroundStyle(.primary)

                // Botão de ação (opcional)
                if let title = item.details.actionTitle,
                   let url = item.details.actionURL {
                    Button {
                        openURL(url)
                    } label: {
                        HStack {
                            Spacer()
                            Text(title).fontWeight(.semibold)
                            Image(systemName: "arrow.up.right.square")
                            Spacer()
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.green))
                        .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 6)
                }
            }
            .padding(16)
        }
        .navigationTitle("Tarefa")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Concluir") {
                    item.isDone = true
                    localDone = true
                    dismiss()
                }
            }
        }
        .onAppear { localDone = item.isDone }
    }
}

// MARK: - UI auxiliar (círculo com check)
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

// MARK: - Conteúdo de exemplo
private let sampleMarkdown = """
**Boas-vindas ao time! Estamos muito felizes com a sua chegada. 🎉**

Sua jornada conosco começa com um mergulho em nossa cultura – o que nos torna únicos.

**Por que isso é importante?**
Mais do que regras, nosso manual compartilha os valores que nos guiam e a missão que nos inspira. Compreendê-lo é o primeiro passo para você fazer parte da nossa história e crescer com a gente.

**O que fazer:**
Acesse o manual pelo botão abaixo. Explore-o no seu ritmo e sinta-se à vontade para levar qualquer dúvida ou reflexão para seu gestor.
"""

// MARK: - Preview
#Preview {
    ChecklistView()
}

