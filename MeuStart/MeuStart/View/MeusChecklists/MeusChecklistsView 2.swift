//
//  MeusChecklistsView 2.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//


import SwiftUI

struct MeusChecklistsView: View {
    @ObservedObject var vm: LoginViewModel   // 👈 ViewModel do login
    @State private var checklists: [Checklist] = [
        .init(titulo: "Onboarding - Primeiros Passos", tarefasConcluidas: 2, totalTarefas: 5),
        .init(titulo: "Treinamento de Integração", tarefasConcluidas: 4, totalTarefas: 5)
    ]
    
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    Color(uiColor: .systemGray6).ignoresSafeArea()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            // Cabeçalho
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Início")
                                    .font(.largeTitle).bold()
                                Text("Olá, Colaborador!")
                                    .font(.title3).bold()
                                    .foregroundStyle(.primary)
                            }
                            .padding(.top, 8)
                            
                            // Seção
                            Text("Seus Checklists:")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            VStack(spacing: 14) {
                                ForEach(checklists) { item in
                                    ChecklistCard(checklist: item) {
                                        print("Abrir \(item.titulo)")
                                    }
                                }
                            }
                            .padding(.top, 4)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                }
                .navigationTitle("Início")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(role: .destructive) {
                            vm.logout()
                        } label: {
                            Label("Sair", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Início")
            }
            
            // Aba Tarefas (placeholder)
            Text("Tarefas")
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tarefas")
                }
            
            // Aba Configurações (placeholder)
            Text("Configurações")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Configurações")
                }
        }
        .tint(.green)
    }
}

#Preview {
    MeusChecklistsView(vm: LoginViewModel())
}
