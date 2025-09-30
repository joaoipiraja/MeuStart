//
//  DashboardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 30/09/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack{
            Text("Início")
                .font(.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 47)
                .padding(.leading, 16)
            Divider()
            
            Spacer()
        }.navigationTitle("Perfil")
        
    }
}

#Preview {
    DashboardView()
}

