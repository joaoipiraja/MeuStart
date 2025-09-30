//
//  LoginView.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 29/09/25.
//


import SwiftUI
import Combine

// MARK: - View

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()

    @FocusState private var focusedField: Field?
    enum Field { case email, password }

    var body: some View {
        NavigationStack {
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
                            .frame(maxWidth: .infinity, minHeight: 50)                            .overlay {
                                if vm.isLoading { ProgressView().tint(.white) }
                            }
                    }
                    .buttonStyle(LoginPrimaryButtonStyle(enabled: vm.canSubmit))
                    .disabled(!vm.canSubmit || vm.isLoading)
                    .padding(.top, 12)

                    if let error = vm.errorMessage {
                        Text(error)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Links
                    VStack(spacing: 16) {
                        Button("Esqueceu sua senha?") { /* ação */ }
                            .font(.callout)
                        Button("Não tem uma conta?") { /* ação */ }
                            .font(.callout)
                    }
                    .tint(.blue)
                    .padding(.top, 8)

                    Spacer(minLength: 12)
                }
                .padding(.horizontal, 20)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Conta")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("OK") { focusedField = nil }
                }
            }
        }
    }
}

#Preview{
    LoginView()
}
