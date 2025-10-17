//
//  MeuStartApp.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 29/09/25.
//

//import SwiftUI
//import SwiftData
//
//@main
//struct MeuStartApp: App {
//    var body: some Scene {
//        WindowGroup {
//            LoginView()
//        }
//        .modelContainer(for: [
//            Employee.self,
//            User.self,
//            TaskItem.self
//        ])
//    }
//}
import SwiftUI
import SwiftData

@main
struct MeuStartApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewWrapper()
        }
        .modelContainer(for: [
            Employee.self,
            User.self,
            TaskItem.self
        ])
    }
}

struct ContentViewWrapper: View {
    @Environment(\.modelContext) private var context

    var body: some View {
        LoginView()
            .task {
                createInitialUsersIfNeeded()
            }
    }

    private func createInitialUsersIfNeeded() {
        do {
            let users = try context.fetch(FetchDescriptor<User>())
            if users.isEmpty {
                // Admin
                let admin = User(
                    name: "Admin",
                    email: "admin@teste.com",
                    password: "123",
                    role: "Administrador",
                    isAdmin: true
                )

                // Usuário comum
                let colaborador = User(
                    name: "João Colaborador",
                    email: "colab@teste.com",
                    password: "123",
                    role: "Colaborador",
                    isAdmin: false
                )

                context.insert(admin)
                context.insert(colaborador)
                try context.save()
                print("👥 Usuários iniciais criados")
            }
        } catch {
            print("❌ Erro ao criar usuários iniciais: \(error)")
        }
    }
}
