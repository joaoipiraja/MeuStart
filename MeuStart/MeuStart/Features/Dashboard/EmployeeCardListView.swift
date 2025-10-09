//
//  EmployeeCardListView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 06/10/25.
//

import SwiftUI

struct EmployeeCardListView: View {
    @StateObject private var viewModel = DashboardViewModel()
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.employees) { employee in
                EmployeeCardView(employee: employee)
                Divider().padding(.leading, 30)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0, x: 0, y: 2)

    }
}

#Preview {
    EmployeeCardListView()
}
