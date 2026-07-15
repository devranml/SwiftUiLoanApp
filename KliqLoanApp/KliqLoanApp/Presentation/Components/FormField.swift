//
//  FormField.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct FormField: View {
    let title: String
    let placeholder: String
    let isSecure: Bool
    let keyboardType: UIKeyboardType
    let submitLabel: SubmitLabel
    let errorMessage: String?
    let colors: any ColorProviding
    let fonts: any FontProviding

    @Binding var text: String

    let onSubmit: () -> Void

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 6
        ) {

            Group {
                if isSecure {
                    SecureField(
                        placeholder,
                        text: $text
                    )
                } else {
                    TextField(
                        placeholder,
                        text: $text
                    )
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                }
            }
            .font(fonts.input)
            .padding(.horizontal, 14)
            .frame(height: 48)
            .background(
                colors.cardBackground
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8
                )
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    borderColor,
                    lineWidth: 1
                )
            }
            .submitLabel(submitLabel)
            .onSubmit(onSubmit)

            if let errorMessage {
                Text(errorMessage)
                    .font(fonts.caption)
                    .foregroundStyle(
                        colors.error
                    )
            }
        }
    }

    private var borderColor: Color {
        if errorMessage != nil {
            return colors.error
        }

        return colors.border
    }
}
