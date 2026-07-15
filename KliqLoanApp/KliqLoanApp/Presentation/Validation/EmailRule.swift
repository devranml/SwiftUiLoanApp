//
//  EmailRule.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import Foundation

struct EmailRule: ValidationRule {
    func validate(_ value: String) -> String? {
        let pattern =
            #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        let result = value.range(
            of: pattern,
            options: .regularExpression
        )

        return result == nil
            ? AppStrings.Validation.invalidEmail
            : nil
    }
}
