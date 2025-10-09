//
//  BottomSheetColaboratorView.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 03/10/25.
//

import SwiftUI

struct BottomSheetColaboratorView: View {
    @Binding var showSheet: Bool
    @State private var items: [ChecklistItem] = [
        .init(
            title: "Assinar o Contrato",
            isDone: true,
            details: .init(
                markdown: sampleMarkdown,
                actionTitle: "Acessar contrato",
                actionURL: URL(string: "https://exemplo.com/contrato")
            )
        ),
        .init(
            title: "Ler o manual de cultura",
            details: .init(
                markdown: sampleMarkdown,
                actionTitle: "Acessar manual de cultura",
                actionURL: URL(string: "https://exemplo.com/manual")
            )
        ),
        .init(title: "Configurar e-mail", details: .init(markdown: sampleMarkdown)),
        .init(title: "Pedir crachá de acesso", details: .init(markdown: sampleMarkdown)),
        .init(title: "Conhecer sua equipe", details: .init(markdown: sampleMarkdown))
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
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
                    }
                }.padding(.horizontal)

                
                    Text("Checklist de Onboarding")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                    //CheckboxListView()
                    ///-----------------------------------
                 
                    List {
                        Section {
                            ForEach(items) { item in
                                NavigationLink(value: item) {
                                    HStack(spacing: 12) {
                                        CheckCircle(isOn: item.isDone)
                                        Text(item.title)
                                            .strikethrough(item.isDone, color: .primary)
                                            .foregroundStyle(.primary)
                                        
                                    }
                                    .padding(.vertical, 6)
                                }
                            }
                        }//.border(.green)
                        .listSectionSpacing(0)

                        
                    }//.border(.black)
                    //.listStyle(.plain)
                    .listStyle(.insetGrouped)
                    .navigationDestination(for: ChecklistItem.self) { item in
                        if let idx = items.firstIndex(where: { $0.id == item.id }) {
                            TaskDetailView(item: $items[idx])
                        } else {
                            TaskDetailView(item: .constant(item))
                        }
                    }
//                    .background(Color.white)
//                    .cornerRadius(12)
//                    .shadow(color: Color.black.opacity(0.05), radius: 0, x: 0, y: 0)
                    ///-----------------------------------
                    Text("Checklist de Integração")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                    
                    CheckboxListView()
                
                    
                Spacer()
                
            }//.padding(.horizontal)
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
