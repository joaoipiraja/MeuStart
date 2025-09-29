//
//  LoginView.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 29/09/25.
//


import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Field?
    @State private var isLoading = false

    enum Field { case email, password }

    // Habilitar botão quando o e-mail não está vazio
    private var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        // ou: !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Campos
                    VStack(spacing: 12) {
                        LabeledField(title: "E-mail") {
                            HStack(spacing: 8) {
                                TextField("E-mail corporativo", text: $email)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .autocorrectionDisabled()
                                    .focused($focusedField, equals: .email)

                                if !email.isEmpty {
                                    Button {
                                        email.removeAll()
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
                            SecureField("Insira sua senha", text: $password)
                                .focused($focusedField, equals: .password)
                        }
                    }
                    .padding(.top, 16)

                    // Botão Entrar
                    Button {
                        submit()
                    } label: {
                        Text("Entrar")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .overlay {
                                if isLoading { ProgressView().tint(.white) }
                            }
                    }
                    .buttonStyle(LoginPrimaryButtonStyle(enabled: canSubmit))
                    .disabled(!canSubmit || isLoading)
                    .padding(.top, 4)

                    // Links
                    VStack(spacing: 16) {
                        Button("Esqueceu sua senha?") {
                            // ação
                        }
                        .font(.callout)

                        Button("Não tem uma conta?") {
                            // ação
                        }
                        .font(.callout)
                    }
                    .tint(Color.blue)
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

    private func submit() {
        guard canSubmit, !isLoading else { return }
        isLoading = true
        // Simulação de login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            isLoading = false
            // navegação ou validação real
        }
    }
}

// MARK: - Componentes Reutilizáveis

struct LabeledField<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(width: 68, alignment: .leading)
            content()
                .font(.subheadline)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.black.opacity(0.08), lineWidth: 0.5)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 1, y: 1)
    }
}

struct LoginPrimaryButtonStyle: ButtonStyle {
    let enabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(enabled ? Color(.systemGreen) : Color(.systemGray5))
            )
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

#Preview {
    LoginView()
}
