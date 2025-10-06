//
//  SummaryItemView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 03/10/25.
//

import SwiftUI

struct SummaryItemView: View {
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
                .foregroundColor(color)
                .frame(width: 40, height: 29)
                .background(color.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(color.opacity(0.6), lineWidth: 1)
                )
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SummaryItemView(title: "oi", value: "oi", color: .blue)
}
