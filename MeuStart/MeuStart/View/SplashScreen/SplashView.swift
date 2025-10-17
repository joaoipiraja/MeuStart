//
//  SplashView.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 29/09/25.
//


import SwiftUI

struct SplashView: View {
    @State private var subtitleVisible = false

    var body: some View {
        VStack(spacing: 54) {
            VStack(spacing: 19) {
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 82)

                Image("title")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 191, height: 32)
            }

            Text("A melhor forma de integrar seus colaboradores.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .frame(maxWidth: 320)
                // estados animados
                .opacity(subtitleVisible ? 1 : 0)
                .offset(y: subtitleVisible ? 0 : 8)
                .animation(.easeOut(duration: 0.6).delay(0.2), value: subtitleVisible)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .onAppear {
            subtitleVisible = true
        }
    }
}

#Preview{
    SplashView()
}
