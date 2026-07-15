//
//  ConfigurableButton.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct ConfigurableButton: View {
    let config: ButtonConfig

    var body: some View {
        Button(action: config.action) {
            Group {
                if config.isLoading {
                    ProgressView()
                        .tint(config.foregroundColor)
                } else {
                    Text(config.title)
                        .font(config.font)
                }
            }
            .foregroundStyle(
                config.foregroundColor
            )
            .frame(maxWidth: .infinity)
            .frame(height: config.height)
            .background(config.backgroundColor)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: config.cornerRadius
                )
            )
        }
        .disabled(config.isLoading)
    }
}
