//
//  TabBarView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 07/10/25.
//

//import SwiftUI
//
//struct TabBarView: View {
//    @State private var selectedTab = 0
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            
//            DashboardView()
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("Início")
//                }
//                .tag(0)
//            
//            Text("Tela Tarefas")
//                .tabItem {
//                    Image(systemName: "list.clipboard.fill")
//                    Text("Tarefas")
//                }
//                .tag(1)
//            Text("Tela Configurações")
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("Configurações")
//                }
//                .tag(2)
//        }
//        .accentColor(Color(red: 48/255, green: 125/255, blue: 20/255))
//    }
//}
//
//#Preview {
//    TabBarView()
//}
import SwiftUI
import SwiftData

struct TabBarView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var vm: LoginViewModel   // 👈 adiciona o ViewModel

    var body: some View {
        let employeeVM = UserViewModel(context: context)

        TabView {
            DashboardView(userVM: employeeVM, vm: vm)
                .tabItem {
                    Label("Início", systemImage: "house.fill")
                }

            Text("Tela Tarefas")
                .tabItem {
                    Label("Tarefas", systemImage: "list.clipboard.fill")
                }

            Text("Tela Configurações")
                .tabItem {
                    Label("Configurações", systemImage: "gear")
                }
        }
        .accentColor(Color(red: 48/255, green: 125/255, blue: 20/255))
    }
}

#Preview {
    TabBarView(vm: LoginViewModel())  // 👈 passa um mock pro preview
}
