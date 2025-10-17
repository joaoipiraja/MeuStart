//
//  CheckboxView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 04/10/25.
//

import SwiftUI

struct CheckboxRow: View {
    @Binding var isChecked: Bool
    let title: String
    let isFirst: Bool
    let isLast: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                isChecked.toggle()
            }
        }) {
            HStack(spacing: 12) {
                // Círculo do checkbox
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                    
                    if isChecked {
                        Image(systemName: "seal.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(red: 48/255, green: 125/255, blue: 20/255))
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.white)
                        
                    }
                }
                
                // Texto
                Text(title)
                    .font(.subheadline)
                    .strikethrough(isChecked, color: .black.opacity(0.6))
                    .foregroundColor(isChecked ? .gray : .primary)
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.6))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color.white)
            .contentShape(Rectangle()) //  garante que toda a área é clicável
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                // Linha divisória entre os itens
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: isLast ? 0 : 1)
                    .padding(.leading, 52),
                alignment: .bottom
            )
        }
        .buttonStyle(PlainButtonStyle()) //  remove highlight azul do botão
    }
    
    private var cornerRadius: CGFloat {
        if isFirst && isLast { return 12 }
        if isFirst { return 12 }
        if isLast { return 12 }
        return 0
    }
}

#Preview {
    VStack(spacing: 0) {
        CheckboxRow(isChecked: .constant(true), title: "Assinar o Contrato", isFirst: true, isLast: false)
//        CheckboxRow(isChecked: .constant(false), title: "Pedir crachá de acesso", isFirst: false, isLast: false)
//        CheckboxRow(isChecked: .constant(false), title: "Conhecer sua equipe", isFirst: false, isLast: true)
    }
    .padding()
    .background(Color(.systemGray6))
}

