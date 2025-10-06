//
//  DashboardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 30/09/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var showSheet = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Início")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                        .padding(.horizontal)
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Acompanhamento de Onboarding")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("RESUMO")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 16)
                            
                            VStack {
                                SummaryItemView(title: "COLABORADORES ATIVOS", value: "05", color: .blue)
                                SummaryItemView(title: "CONCLUÍDOS (MÊS)", value: "04", color: .green)
                                SummaryItemView(title: "EM ATRASO", value: "01", color: .red)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                      
                        
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Lista de Colaboradores")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Button(action: {}) {
                                Text("Todos")
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 20)
                                    .background(Color(red: 48/255, green: 125/255, blue: 20/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            Menu {
                                Button("Nome") {}
                                Button("Status") {}
                            } label: {
                                HStack {
                                    Text("Ordenar por").foregroundColor(.black)
                                    Image(systemName: "chevron.down").foregroundColor(.black)
                                }
                                .padding(.vertical, 16)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.9))
                                )
                            }
                        }
                        
                        VStack(spacing: 12) {
                            EmployeeCardListView().onTapGesture {
                                showSheet = true
                            }
                        }.sheet(isPresented: $showSheet) {
                            BottomSheetColaboratorView(showSheet: $showSheet)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                   
                }
            }.background(Color(UIColor.systemGray6))
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Início", systemImage: "house.fill")
            }
            .navigationTitle("Inicio")
            //.padding(.horizontal)
        }
    }



#Preview {
    DashboardView()
}


