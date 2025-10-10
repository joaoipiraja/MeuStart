//
//  DashboardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 30/09/25.
//


import SwiftUI


struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Início")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 56)
                            .padding(.horizontal)
                        Divider()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 252/255, green: 252/255, blue: 253/255))
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Acompanhamento de Onboarding")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 20)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("RESUMO")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 16)
                            
                            VStack {
                                SummaryItemView(title: "COLABORADORES ATIVOS", value: viewModel.employees.count, color: .blue)
                                SummaryItemView(title: "CONCLUÍDOS (MÊS)", value: viewModel.employees.filter { $0.status == .completed }.count, color: .green)
                                SummaryItemView(title: "EM ATRASO", value: viewModel.employees.filter { $0.status == .delayed }.count, color: .red)

                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                    }
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Lista de Colaboradores")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.vertical, 10)
                        
                        HStack {
                            Menu {
                                ForEach(DashboardViewModel.FilterOption.allCases, id: \.self) { filter in
                                    Button(filter.rawValue) {
                                        viewModel.selectedFilter = filter
                                    }
                                }
                            } label: {
                                Text(viewModel.selectedFilter.rawValue)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 20)
                                    .background(Color(red: 48/255, green: 125/255, blue: 20/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            Menu {
                                ForEach(DashboardViewModel.SortOption.allCases, id: \.self) { sort in
                                    Button(sort.rawValue) {
                                        viewModel.selectedSort = sort
                                        viewModel.sortEmployees()
                                    }
                                }
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
                            EmployeeCardListView(
                                employees: viewModel.filteredEmployees(),
                                onEmployeeTap: { employee in
                                    viewModel.selectedEmployee = employee
                                    viewModel.showSheet = true
                                }
                            )
                            .sheet(isPresented: $viewModel.showSheet) {
                                if let employee = viewModel.selectedEmployee {
                                    BottomSheetColaboratorView(
                                        employee: employee, showSheet: $viewModel.showSheet
                                    )
                                    .presentationDragIndicator(.visible)
                                }
                            }
  
                        }

                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
                .background(Color(UIColor.systemGray6))
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Label("Início", systemImage: "house.fill")
        }
    }
}

#Preview {
    DashboardView()
}
