//
//  EmployeeCardListView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 06/10/25.
//

import SwiftUI

struct EmployeeCardListView: View {
    let employees: [Employee]
    var onEmployeeTap: (Employee) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(employees) { employee in
                EmployeeCardView(employee: employee)
                    .onTapGesture {
                        onEmployeeTap(employee)
                    }
                Divider().padding(.leading, 30)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0, x: 0, y: 2)
    }
}

#Preview {
    EmployeeCardListView(employees: [
        Employee(
            name: "João Vitor",
            role: "Product Designer",
            manager: "Maria Souza",
            status: .atention,
            startDate: "01/10/2025"
        ),
        Employee(
            name: "Beatriz Andrade",
            role: "Analista Financeiro",
            manager: "Carlos Lima",
            status: .completed,
            startDate: "05/09/2025"
        ),
        Employee(
            name: "Manoel Gomes",
            role: "Auxiliar Administrativo",
            manager: "Paula Ribeiro",
            status: .delayed,
            startDate: "20/09/2025"
        )
    ], onEmployeeTap: {_ in}
    )
}

