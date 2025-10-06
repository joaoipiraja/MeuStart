//
//  EmployeeCardListView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 06/10/25.
//

import SwiftUI

struct EmployeeCardListView: View {
    var body: some View {
        VStack(spacing: 0) {
            EmployeeCardView(name: "André de Lima Freitas", role: "Product Designer", status: .concluido)
            Divider().padding(.leading, 30).padding(.vertical, 2)
            EmployeeCardView(name: "Manoel Gomes Ferreira", role: "Auxiliar Administrativo", status: .atraso)
            Divider().padding(.leading, 30)
            EmployeeCardView(name: "Beatriz Maria Andrade", role: "Analista Financeiro", status: .atencao)
            Divider().padding(.leading, 30)
            EmployeeCardView(name: "Clarece de Sousa Dourado", role: "Diretora de Marketing", status: .atencao)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0, x: 0, y: 2)

    }
}

#Preview {
    EmployeeCardListView()
}
