//
//  ValidationRule.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol ValidationRule {
    func validate(_ value: String) -> String?
}
