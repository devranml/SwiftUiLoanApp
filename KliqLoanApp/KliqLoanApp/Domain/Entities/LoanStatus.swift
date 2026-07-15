//
//  LoanStatus.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

public enum LoanStatus: String, Codable, Hashable {
    case active
    case overdue
    case `default`
    case paid
}
