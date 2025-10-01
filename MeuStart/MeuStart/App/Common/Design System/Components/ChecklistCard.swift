//
//  ChecklistCard.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//

import SwiftUI

struct ChecklistCard: View {
    let checklist: Checklist
    var abrirAcao: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(checklist.titulo)
                .font(.headline)
                .foregroundStyle(.primary)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Text("Progresso:")
                        .font(.subheadline).bold()
                    Text(checklist.progressoTexto)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                ProgressBar(value: checklist.progresso)
                    .frame(height: 6)
            }
            
            HStack {
                Spacer()
                Button(action: abrirAcao) {
                    HStack(spacing: 6) {
                        Text("Abrir checklist")
                        Image(systemName: "chevron.right")
                    }
                }
                .font(.subheadline)
                .foregroundStyle(.primary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
    }
}
