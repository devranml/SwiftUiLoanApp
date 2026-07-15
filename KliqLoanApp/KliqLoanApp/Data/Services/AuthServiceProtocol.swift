//
//  AuthServiceProtocol.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

//MARK: AuthServiceProtocol
protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws
    func logout() async throws
}
