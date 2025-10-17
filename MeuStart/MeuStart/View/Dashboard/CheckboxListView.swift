//
//  CheckboxListView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 04/10/25.
//

import SwiftUI

struct CheckboxListView: View {
    var body: some View {
        VStack {
            CheckboxRow(isChecked: .constant(true), title: "Assinar o Contrato", isFirst: true, isLast: false)
            CheckboxRow(isChecked: .constant(false), title: "Assinar o Contrato", isFirst: true, isLast: false)
            CheckboxRow(isChecked: .constant(false), title: "Assinar o Contrato", isFirst: true, isLast: false)
            CheckboxRow(isChecked: .constant(false), title: "Assinar o Contrato", isFirst: true, isLast: false)
        }
            //.padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 0, x: 0, y: 2)
            //.padding(.horizontal)
            //.padding(.bottom, 32)
            

    }
}

#Preview {
    CheckboxListView()
}
