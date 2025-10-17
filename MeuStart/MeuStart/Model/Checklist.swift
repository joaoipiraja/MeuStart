//
//  Checklist.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//

//import Foundation
//
//struct Checklist: Identifiable {
//    let id = UUID()
//    let titulo: String
//    let tarefasConcluidas: Int
//    let totalTarefas: Int
//    
//    var progresso: Double { totalTarefas == 0 ? 0 : Double(tarefasConcluidas) / Double(totalTarefas) }
//    var progressoTexto: String { "\(tarefasConcluidas) de \(totalTarefas) tarefas concluídas" }
//}

import Foundation

struct Checklist: Identifiable {
    let id = UUID()
    let titulo: String
    let tarefasConcluidas: Int
    let totalTarefas: Int
    
    var progresso: Double {
        totalTarefas == 0 ? 0 : Double(tarefasConcluidas) / Double(totalTarefas)
    }
    
    var progressoTexto: String {
        "\(tarefasConcluidas) de \(totalTarefas) tarefas concluídas"
    }
}
