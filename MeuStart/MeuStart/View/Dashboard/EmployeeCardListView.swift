//
//  EmployeeCardListView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 06/10/25.
//
//
//  UserCardListView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 17/10/25.
//

import SwiftUI

struct UserCardListView: View {
    let users: [User]
    var onUserTap: (User) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(users) { user in
                UserCardView(user: user)
                    .onTapGesture {
                        onUserTap(user)
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
    UserCardListView(
        users: [
            User(
                name: "João Vitor",
                email: "joao@teste.com",
                password: "123",
                role: "Product Designer",
                isAdmin: false,
                manager: "Maria Souza",
                status: .atention,
                startDate: .now
            ),
            User(
                name: "Beatriz Andrade",
                email: "bia@teste.com",
                password: "123",
                role: "Analista Financeiro",
                isAdmin: false,
                manager: "Carlos Lima",
                status: .completed,
                startDate: .now
            ),
            User(
                name: "Manoel Gomes",
                email: "manoel@teste.com",
                password: "123",
                role: "Auxiliar Administrativo",
                isAdmin: false,
                manager: "Paula Ribeiro",
                status: .delayed,
                startDate: .now
            )
        ],
        onUserTap: { _ in }
    )
}
