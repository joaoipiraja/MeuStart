////
////  Checklist.swift
////  MeuStart
////
////  Created by João Victor Ipirajá de Alencar on 30/09/25.
////
//
//
//import SwiftUI
//
//// MARK: - Views
//struct MeusChecklistsView: View {
//    @State private var checklists: [Checklist] = [
//        .init(titulo: "Onboarding - Primeiros Passos", tarefasConcluidas: 2, totalTarefas: 5),
//        .init(titulo: "Treinamento de Integração", tarefasConcluidas: 4, totalTarefas: 5)
//    ]
//    
//    var body: some View {
//        TabView {
//            NavigationStack {
//                ZStack {
//                    Color(uiColor: .systemGray6).ignoresSafeArea()
//                    
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 16) {
//                            
//                            // Cabeçalho
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text("Início")
//                                    .font(.largeTitle).bold()
//                                Text("Olá, João!")
//                                    .font(.title3).bold()
//                                    .foregroundStyle(.primary)
//                            }
//                            .padding(.top, 8)
//                            
//                            // Seção
//                            Text("Seus Checklists:")
//                                .font(.headline)
//                                .padding(.top, 8)
//                            
//                            VStack(spacing: 14) {
//                                ForEach(checklists) { item in
//                                    ChecklistCard(checklist: item) {
//                                        // ação do botão "Abrir checklist"
//                                        print("Abrir \(item.titulo)")
//                                    }
//                                }
//                            }
//                            .padding(.top, 4)
//                        }
//                        .padding(.horizontal, 20)
//                        .padding(.bottom, 24)
//                    }
//                }
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .principal) { EmptyView() } // remove título do NavBar
//                }
//            }
//            .tabItem {
//                Image(systemName: "house.fill")
//                Text("Início")
//            }
//            
//            // Aba Tarefas (placeholder)
//            Text("Tarefas")
//                .tabItem {
//                    Image(systemName: "checklist")
//                    Text("Tarefas")
//                }
//            
//            // Aba Configurações (placeholder)
//            Text("Configurações")
//                .tabItem {
//                    Image(systemName: "gearshape")
//                    Text("Configurações")
//                }
//        }
//        // Mantém uma cor visível para os ícones
//        .tint(.green)
//    }
//}
//
//
//// MARK: - Preview
//#Preview {
//    MeusChecklistsView()
//}
