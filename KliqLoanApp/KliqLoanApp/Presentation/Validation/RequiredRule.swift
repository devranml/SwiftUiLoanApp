//
//  RequiredRule.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

struct RequiredRule: ValidationRule {
    func validate(_ value: String) -> String? {
        value.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
        ? AppStrings.Validation.required
        : nil
    }
}
