//
//  LoginView.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 29/09/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var vm = LoginViewModel()

    @FocusState private var focusedField: Field?
    enum Field { case email, password }

    var body: some View {
        NavigationStack {
            if let user = vm.loggedUser {
                if user.isAdmin {
                    DashboardView(employeeVM: EmployeeViewModel(context: context), vm: vm)

                } else {
                    MeusChecklistsView(vm: vm)
                }
            } else {
                loginContent
                    .onAppear {
                        vm.setAuthService(AuthService(context: context))

                        // 👇 Diagnóstico: listar usuários do banco
                        do {
                            let all = try context.fetch(FetchDescriptor<User>())
                            print("📦 Usuários no banco: \(all.map { $0.email })")
                        } catch {
                            print("❌ Erro ao listar usuários: \(error)")
                        }
                    }
                    .navigationTitle("Conta")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("OK") { focusedField = nil }
                        }
                    }
            }
        }
    }

    private var loginContent: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Campos
                VStack(spacing: 12) {
                    LabeledField(title: "E-mail") {
                        HStack(spacing: 8) {
                            TextField("E-mail corporativo", text: $vm.email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .focused($focusedField, equals: .email)

                            if !vm.email.isEmpty {
                                Button {
                                    vm.clearEmail()
                                    focusedField = .email
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.secondary)
                                }
                                .accessibilityLabel("Limpar e-mail")
                            }
                        }
                    }

                    LabeledField(title: "Senha") {
                        SecureField("Insira sua senha", text: $vm.password)
                            .focused($focusedField, equals: .password)
                    }
                }
                .padding(.top, 16)

                // Botão Entrar
                Button {
                    vm.submit()
                } label: {
                    Text("Entrar")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .overlay {
                            if vm.isLoading { ProgressView().tint(.white) }
                        }
                }
                .buttonStyle(LoginPrimaryButtonStyle(enabled: vm.canSubmit))
                .disabled(!vm.canSubmit || vm.isLoading)
                .padding(.top, 12)

                // Erro
                if let error = vm.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                VStack(spacing: 16) {
                    Button("Esqueceu sua senha?") { }
                        .font(.callout)
                    Button("Não tem uma conta?") { }
                        .font(.callout)
                }
                .tint(.blue)
                .padding(.top, 8)
            }
            .padding(.horizontal, 20)
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

#Preview {
    LoginView()
        .modelContainer(for: [User.self, Employee.self])
}
