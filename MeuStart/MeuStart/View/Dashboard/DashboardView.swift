//
//  DashboardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 30/09/25.
//


//import SwiftUI
//import SwiftData
//
//
//struct DashboardView: View {
//    
//    @Environment(\.modelContext) private var context
//    @StateObject private var viewModel = DashboardViewModel(context: context)
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 0) {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Início")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .padding(.top, 56)
//                            .padding(.horizontal)
//                        Divider()
//                    }
//                    .frame(maxWidth: .infinity)
//                    .background(Color(red: 252/255, green: 252/255, blue: 253/255))
//                    VStack(alignment: .leading, spacing: 1) {
//                        Text("Acompanhamento de Onboarding")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                            .padding(.horizontal)
//                            .padding(.vertical, 20)
//                        
//                        VStack(alignment: .leading, spacing: 16) {
//                            Text("RESUMO")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .padding(.top, 16)
//                            
//                            VStack {
//                                SummaryItemView(title: "COLABORADORES ATIVOS", value: viewModel.employees.count, color: .blue)
//                                SummaryItemView(title: "CONCLUÍDOS (MÊS)", value: viewModel.employees.filter { $0.status == .completed }.count, color: .green)
//                                SummaryItemView(title: "EM ATRASO", value: viewModel.employees.filter { $0.status == .delayed }.count, color: .red)
//
//                            }
//                        }
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(12)
//                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
//                        .padding(.horizontal)
//                        .padding(.bottom, 15)
//                    }
//                    VStack(alignment: .leading, spacing: 11) {
//                        Text("Lista de Colaboradores")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                            .padding(.vertical, 10)
//                        
//                        HStack {
//                            Menu {
//                                ForEach(DashboardViewModel.FilterOption.allCases, id: \.self) { filter in
//                                    Button(filter.rawValue) {
//                                        viewModel.selectedFilter = filter
//                                    }
//                                }
//                            } label: {
//                                Text(viewModel.selectedFilter.rawValue)
//                                    .fontWeight(.semibold)
//                                    .padding(.vertical, 16)
//                                    .padding(.horizontal, 20)
//                                    .background(Color(red: 48/255, green: 125/255, blue: 20/255))
//                                    .foregroundColor(.white)
//                                    .cornerRadius(8)
//                            }
//                            
//                            Menu {
//                                ForEach(DashboardViewModel.SortOption.allCases, id: \.self) { sort in
//                                    Button(sort.rawValue) {
//                                        viewModel.selectedSort = sort
//                                        viewModel.sortEmployees()
//                                    }
//                                }
//                            } label: {
//                                HStack {
//                                    Text("Ordenar por").foregroundColor(.black)
//                                    Image(systemName: "chevron.down").foregroundColor(.black)
//                                }
//                                .padding(.vertical, 16)
//                                .padding(.horizontal, 20)
//                                .background(Color.white)
//                                .cornerRadius(8)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.gray.opacity(0.9))
//                                )
//                            }
//                        }
//                        
//                        VStack(spacing: 12) {
//                            EmployeeCardListView(
//                                employees: viewModel.filteredEmployees(),
//                                onEmployeeTap: { employee in
//                                    viewModel.selectedEmployee = employee
//                                    viewModel.showSheet = true
//                                }
//                            )
//                            .sheet(isPresented: $viewModel.showSheet) {
//                                if let employee = viewModel.selectedEmployee {
//                                    BottomSheetColaboratorView(
//                                        employee: employee, showSheet: $viewModel.showSheet
//                                    )
//                                    .presentationDragIndicator(.visible)
//                                }
//                            }
//  
//                        }
//
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom, 32)
//                }
//                .background(Color(UIColor.systemGray6))
//            }.onAppear {
//                viewModel.setContext(context)
//            }
//            .background(Color.white)
//            .navigationBarHidden(true)
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .tabItem {
//            Label("Início", systemImage: "house.fill")
//        }
//    }
//}
//
//#Preview {
//    DashboardView()
//}
//
//  DashboardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//
//
//  DashboardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 09/10/25.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @ObservedObject var vm: LoginViewModel
    @ObservedObject var userVM: UserViewModel
    @StateObject private var viewModel: DashboardViewModel

    @State private var showingUserManager = false
    @State private var showingTaskManager = false

    init(userVM: UserViewModel, vm: LoginViewModel) {
        self._userVM = ObservedObject(initialValue: userVM)
        self._viewModel = StateObject(wrappedValue: DashboardViewModel(userVM: userVM))
        self._vm = ObservedObject(initialValue: vm)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {

                    // 🔹 Cabeçalho
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

                    // 🔹 Seção de resumo
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Acompanhamento de Onboarding")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 20)

                        VStack {
                            SummaryItemView(
                                title: "COLABORADORES ATIVOS",
                                value: viewModel.atentionCount,
                                color: .blue
                            )
                            SummaryItemView(
                                title: "CONCLUÍDOS (MÊS)",
                                value: viewModel.completedCount,
                                color: .green
                            )
                            SummaryItemView(
                                title: "EM ATRASO",
                                value: viewModel.delayedCount,
                                color: .red
                            )
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                    }

                    // 🔹 Lista de usuários (colaboradores)
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Lista de Colaboradores")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.vertical, 10)

                        // Filtros
                        HStack {
                            Menu {
                                ForEach(DashboardViewModel.FilterOption.allCases, id: \.self) { filter in
                                    Button(filter.rawValue) {
                                        viewModel.selectedFilter = filter
                                        viewModel.applyFilters()
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
                                        viewModel.applyFilters()
                                    }
                                }
                            } label: {
                                HStack {
                                    Text("Ordenar por")
                                    Image(systemName: "chevron.down")
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

                        // Cartões de usuários
                        UserCardListView(
                            users: viewModel.filteredList,
                            onUserTap: { user in
                                viewModel.selectedUser = user
                                viewModel.showSheet = true
                            }
                        )
                        .sheet(isPresented: $viewModel.showSheet) {
                            if let user = viewModel.selectedUser {
                                BottomSheetColaboratorView(
                                    user: user,
                                    showSheet: $viewModel.showSheet
                                )
                                .presentationDragIndicator(.visible)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
                .background(Color(UIColor.systemGray6))
            }

            // 🔹 Toolbars
            .navigationBarHidden(false)
            .toolbar {
                // Botão de logout (esquerda)
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .destructive) {
                        vm.logout()
                    } label: {
                        Label("Sair", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }

                // Botões do admin (direita)
                ToolbarItem(placement: .topBarTrailing) {
                    if vm.loggedUser?.isAdmin == true {
                        HStack(spacing: 14) {
                            // 🔵 Gerenciar tarefas
                            Button {
                                showingTaskManager = true
                            } label: {
                                Image(systemName: "list.bullet.rectangle.portrait")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }

                            // 🟢 Gerenciar usuários
                            Button {
                                showingUserManager = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                        }
                    }
                }
            }

            // Sheets
            .sheet(isPresented: $showingUserManager) {
                UserManagerView()
            }
            .sheet(isPresented: $showingTaskManager) {
                TaskManagerView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    DashboardView(
        userVM: UserViewModel(
            context: .init(try! ModelContainer(for: User.self))
        ),
        vm: LoginViewModel()
    )
}
