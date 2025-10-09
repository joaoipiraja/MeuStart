//
//  EmployedCardView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 03/10/25.
//

import SwiftUI

struct EmployeeCardView: View {
    let employee: Employee
    
    var color: Color {
        switch employee.status {
        case .completed: return .green
        case .delayed: return .red
        case .atention: return .yellow
        }
    }
    
    var labelText: String {
        switch employee.status {
        case .completed: return "Concluído"
        case .delayed: return "Atrasado"
        case .atention: return "Atenção"
        }
    }
    
  
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
                .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(employee.name)
                    .fontWeight(.semibold)
                HStack{
                    Text("CARGO:")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(employee.role.uppercased())
                        .font(.caption)
                }

                
                Text(labelText)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(color.opacity(0.1))
                    .foregroundColor(color)
                    .cornerRadius(10)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.top, 25)
        }
        .padding()
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(Color.white)
        .cornerRadius(12)
    }
}


#Preview {
    EmployeeCardView(employee: Employee(name: "João Vitor", role: "Product Designer", status: .atention))
}

