//
//  LoginView.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

private enum LoginFocusedField: Hashable {
    case email
    case password
}

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel

    @FocusState private var focusedField:
        LoginFocusedField?

    private let colors: any ColorProviding
    private let fonts: any FontProviding

    init(
        viewModel: LoginViewModel,
        colors: any ColorProviding,
        fonts: any FontProviding
    ) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )

        self.colors = colors
        self.fonts = fonts
    }

    var body: some View {
        VStack(spacing: 14) {
            Image("kliq_logo")
                .resizable()
                .scaledToFit()
                .frame(height: 50)

            FormField(
                title: AppStrings.Login.emailTitle,
                placeholder:
                    AppStrings.Login.emailPlaceholder,
                isSecure: false,
                keyboardType: .emailAddress,
                submitLabel: .next,
                errorMessage:
                    viewModel.form.emailError,
                colors: colors,
                fonts: fonts,
                text: $viewModel.form.email,
                onSubmit: {
                    viewModel.validateEmail()

                    if viewModel.form.emailError == nil {
                        focusedField = .password
                    }
                }
            )
            .focused(
                $focusedField,
                equals: .email
            )

            FormField(
                title:
                    AppStrings.Login.passwordTitle,
                placeholder:
                    AppStrings.Login.passwordPlaceholder,
                isSecure: true,
                keyboardType: .default,
                submitLabel: .go,
                errorMessage:
                    viewModel.form.passwordError,
                colors: colors,
                fonts: fonts,
                text: $viewModel.form.password,
                onSubmit: {
                    Task {
                        await viewModel.signIn()
                    }
                }
            )
            .focused(
                $focusedField,
                equals: .password
            )

            ConfigurableButton(
                config: ButtonConfig(
                    title: AppStrings.Login.signIn,
                    foregroundColor: .white,
                    backgroundColor: colors.primary,
                    disabledBackgroundColor:
                        colors.primary.opacity(0.45),
                    font: fonts.button,
                    height: 50,
                    cornerRadius: 10,
                    isLoading:
                        viewModel.isLoading,
                    action: {
                        Task {
                            await viewModel.signIn()
                        }
                    }
                )
            )
        }
        .padding(.horizontal, 32)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            colors.background
                .ignoresSafeArea()
        )
        .navigationTitle(
            AppStrings.Login.navigationTitle
        )
        .navigationBarTitleDisplayMode(.inline)
        .presentationState(
            viewModel: viewModel
        )
        .onAppear {
            focusedField = .email
        }
    }
}
