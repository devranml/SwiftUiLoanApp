//
//  ValidationProvider.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

protocol ValidationProviding {
    func validate(_ value: String, rules: [any ValidationRule]) -> String?
}

struct ValidationProvider: ValidationProviding {
    func validate(_ value: String, rules: [any ValidationRule]) -> String? {
        for rule in rules {
            if let error = rule.validate(value) {
                return error
            }
        }

        return nil
    }
}
