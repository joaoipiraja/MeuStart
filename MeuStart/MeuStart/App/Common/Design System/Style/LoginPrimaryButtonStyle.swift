//
//  LoginPrimaryButtonStyle.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//

import SwiftUI

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
