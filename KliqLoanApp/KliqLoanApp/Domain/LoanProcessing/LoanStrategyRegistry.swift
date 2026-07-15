//
//  LoanStrategyRegistry.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//
import Foundation

enum LoanStrategyRegistryError: LocalizedError {
    case unsupportedType

    var errorDescription: String? {
        AppStrings.Error.unsupportedLoanType
    }
}

struct LoanStrategyRegistry {
    private let strategies: [
        LoanType: any LoanProcessingStrategy
    ]

    init(strategies: [any LoanProcessingStrategy]) {
        self.strategies = Dictionary(uniqueKeysWithValues: strategies.map {
                ($0.supportedType, $0)
            }
        )
    }

    func strategy(for type: LoanType) throws -> any LoanProcessingStrategy {
        guard let strategy = strategies[type] else {
            throw LoanStrategyRegistryError.unsupportedType
        }
        return strategy
    }
}
