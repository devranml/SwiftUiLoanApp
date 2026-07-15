//
//  Loan.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

public struct Loan: Codable,Equatable {
    var name: String
    var principalAmount: Double
    var interestRate: Double
    var status: LoanStatus
    var dueIn: Int
    var type: LoanType
}
