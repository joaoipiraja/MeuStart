//
//  User.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 14/10/25.
//
//
//import SwiftData
//import Foundation
//
//@Model
//final class User {
//    var id: UUID
//    var name: String
//    var email: String
//    var employees: [Employee] = []
//
//    init(
//        id: UUID = UUID(),
//        name: String,
//        email: String
//    ) {
//        self.id = id
//        self.name = name
//        self.email = email
//    }
//}
//
//  User.swift
//  MeuStart
//
//  Created by João Vitor Alves Holanda on 16/10/25.
//


import Foundation
import SwiftData

@Model
final class User {
    var name: String
    var email: String
    var password: String
    var role: String
    var isAdmin: Bool

    init(name: String, email: String, password: String, role: String, isAdmin: Bool = false) {
        self.name = name
        self.email = email
        self.password = password
        self.role = role
        self.isAdmin = isAdmin
    }
}


