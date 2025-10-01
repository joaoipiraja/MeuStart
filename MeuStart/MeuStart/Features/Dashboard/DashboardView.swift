//
//  DashboardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 30/09/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Início")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                    Divider()
        
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Acompanhamento de Onboarding")
                            .font(.headline)
                            
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("RESUMO")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 16)
                            
                            VStack {
                                SummaryItem(title: "COLABORADORES ATIVOS", value: "05", color: .blue)
                                SummaryItem(title: "CONCLUÍDOS (MÊS)", value: "04", color: .green)
                                SummaryItem(title: "EM ATRASO", value: "01", color: .red)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                    
                    // MARK: - Lista de Colaboradores
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Lista de Colaboradores")
                            .font(.headline)
                        
                        HStack {
                            Button(action: {}) {
                                Text("Todos")
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 16)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            Menu {
                                Button("Nome") {}
                                Button("Status") {}
                            } label: {
                                HStack {
                                    Text("Ordenar por")
                                    Image(systemName: "chevron.down")
                                }
                                .padding(.vertical, 6)
                                .padding(.horizontal, 16)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                            }
                        }
                        
                        VStack(spacing: 12) {
                            EmployeeCard(name: "André de Lima Freitas", role: "Product Designer", status: .concluido)
                            EmployeeCard(name: "Manoel Gomes Ferreira", role: "Auxiliar Administrativo", status: .atraso)
                            EmployeeCard(name: "Beatriz Maria Andrade", role: "Analista Financeiro", status: .atencao)
                            EmployeeCard(name: "Clarice de Sousa Dourado", role: "Diretora de Marketing", status: .atencao)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .background(Color(UIColor.systemGray6))
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Label("Início", systemImage: "house.fill")
        }
    }
}

struct SummaryItem: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(color)
                .multilineTextAlignment(.center)
            Spacer()
            Text(value)
                .font(.headline)
                .padding(.top, 4)
                .frame(width: 40, height: 28)
                .background(color.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(color.opacity(0.6), lineWidth: 1)
                )
        }
        .frame(maxWidth: .infinity)
    }
}

struct EmployeeCard: View {
    enum Status {
        case concluido, atraso, atencao
        
        var color: Color {
            switch self {
            case .concluido: return .green
            case .atraso: return .red
            case .atencao: return .yellow
            }
        }
        
        var text: String {
            switch self {
            case .concluido: return "CONCLUÍDO"
            case .atraso: return "COM ATRASO"
            case .atencao: return "ATENÇÃO"
            }
        }
    }
    
    let name: String
    let role: String
    let status: Status
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(status.color)
                .frame(width: 10, height: 10)
                .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .fontWeight(.semibold)
                Text("CARGO: \(role.uppercased())")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(status.text)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(status.color.opacity(0.1))
                    .foregroundColor(status.color)
                    .cornerRadius(6)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    DashboardView()
}


