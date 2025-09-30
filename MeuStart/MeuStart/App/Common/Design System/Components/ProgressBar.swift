//
//  ProgressBar.swift
//  MeuStart
//
//  Created by João Victor Ipirajá de Alencar on 30/09/25.
//

import SwiftUI

struct ProgressBar: View {
    let value: Double // 0.0 ... 1.0
    var trackColor: Color = .gray.opacity(0.25)
    var fillColor: Color = .green
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(trackColor)
                Capsule()
                    .fill(fillColor)
                    .frame(width: max(0, min(1, value)) * geo.size.width)
            }
        }
    }
}
