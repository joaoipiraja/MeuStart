//
//  TaskDetailView.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 09/10/25.
//

import SwiftUI

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
