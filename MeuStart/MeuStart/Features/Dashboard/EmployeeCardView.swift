//
//  EmployedCardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 03/10/25.
//

import SwiftUI

struct EmployeeCardView: View {
    enum Status {
        case concluido, atraso, atencao
        
        var color: Color {
            switch self {
            case .concluido: return .green
            case .atraso: return .red
            case .atencao: return .yellow
            }
        }
        
        var text: String {
            switch self {
            case .concluido: return "CONCLUÍDO"
            case .atraso: return "COM ATRASO"
            case .atencao: return "ATENÇÃO"
            }
        }
    }
    
    let name: String
    let role: String
    let status: Status
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(status.color)
                .frame(width: 10, height: 10)
                .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .fontWeight(.semibold)
                HStack{
                    Text("CARGO:")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(role.uppercased())
                        .font(.caption)
                }

                
                Text(status.text)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(status.color.opacity(0.1))
                    .foregroundColor(status.color)
                    .cornerRadius(10)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.top, 25)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}


#Preview {
    EmployeeCardView(name: "Name", role: "Product Designer", status: .atencao)
}
