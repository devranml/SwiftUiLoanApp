//
//  View+PresentationState.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

extension View {
    func presentationState<ViewModel: BaseViewModel>(
        viewModel: ViewModel
    ) -> some View {
        overlay {
            if viewModel.isLoading {
                LoadingOverlay()
            }
        }
        .alert(
            AppStrings.Error.title,
            isPresented: Binding(
                get: {
                    viewModel.errorMessage != nil
                },
                set: { isPresented in
                    if !isPresented {
                        viewModel.clearError()
                    }
                }
            )
        ) {
            Button(
                AppStrings.Error.ok,
                role: .cancel
            ) {
                viewModel.clearError()
            }
        } message: {
            Text(
                viewModel.errorMessage ?? ""
            )
        }
    }
}
