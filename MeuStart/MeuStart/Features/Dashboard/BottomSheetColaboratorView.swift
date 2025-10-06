//
//  BottomSheetColaboratorView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 03/10/25.
//

import SwiftUI

struct BottomSheetColaboratorView: View {
    @Binding var showSheet: Bool
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Manoel Gomes Ferreira")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("CONCLUÍDO")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.green.opacity(0.3))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        Text("CARGO:")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text(" Product Designer")
                            .font(.caption)
                    }
                    HStack{
                        Text("GESTOR:")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("CARLOS SOUZA")
                            .font(.caption)
                    }
                    HStack{
                        Text("DATA DE INÍCIO:")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("22/09/2025")
                            .font(.caption)
                    }
                }//.padding(.bottom, 16)
                
                VStack{
                    Text("Checklist de Onboarding")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                    CheckboxListView()
                    Text("Checklist de Integração")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                    
                    CheckboxListView()
                }
                    

            
                Spacer()
            }.padding(.horizontal)
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Ficha do Colaborador")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showSheet = false // Fecha a sheet
                    }) {
                        HStack {
                            Text("Voltar")
                        }
                    }
                }
            }
        }.presentationDragIndicator(.visible)
    }
}


#Preview {
    @Previewable @State var showSheet2 = true
    BottomSheetColaboratorView(showSheet: $showSheet2)
}
