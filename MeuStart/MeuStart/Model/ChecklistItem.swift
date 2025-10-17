//
//  ChecklistItem.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 09/10/25.
//

import Foundation

struct ChecklistItem: Identifiable, Hashable {
    struct Details: Equatable, Hashable {
        var markdown: String
        var actionTitle: String?
        var actionURL: URL?
    }

    let id = UUID()
    var title: String
    var isDone: Bool = false
    var details: Details
}

let sampleMarkdown = """
**Boas-vindas ao time! Estamos muito felizes com a sua chegada. 🎉**

Sua jornada conosco começa com um mergulho em nossa cultura – o que nos torna únicos.

**Por que isso é importante?**
Mais do que regras, nosso manual compartilha os valores que nos guiam e a missão que nos inspira. Compreendê-lo é o primeiro passo para você fazer parte da nossa história e crescer com a gente.

**O que fazer:**
Acesse o manual pelo botão abaixo. Explore-o no seu ritmo e sinta-se à vontade para levar qualquer dúvida ou reflexão para seu gestor.
"""
