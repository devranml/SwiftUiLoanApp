//
//  MinimumLengthRule.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

struct MinimumLengthRule: ValidationRule {
    let minimumLength: Int

    func validate(_ value: String) -> String? {
        value.count < minimumLength
        ? AppStrings.Validation.minimumLength(
            minimumLength
        )
        : nil
    }
}
