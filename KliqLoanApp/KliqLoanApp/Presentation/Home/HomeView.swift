//
//  HomeView.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    private let colors: any ColorProviding
    private let fonts: any FontProviding

    init(
        viewModel: HomeViewModel,
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
        VStack(spacing: 12) {
            LoanSummaryCard(
                totalAmount:
                    viewModel.totalAmountText,
                countText:
                    viewModel.loanCountText,
                averageRateText:
                    viewModel.averageRateText,
                colors: colors,
                fonts: fonts
            )

            Picker(
                "",
                selection:
                    $viewModel.selectedFilter
            ) {
                ForEach(
                    LoanFilter.allCases,
                    id: \.self
                ) { filter in
                    Text(filter.title)
                        .tag(filter)
                }
            }
            .pickerStyle(.segmented)

            if viewModel.filteredLoans.isEmpty,
               !viewModel.isLoading {
                ContentUnavailableView(
                    AppStrings.Home.emptyTitle,
                    systemImage:
                        "doc.text.magnifyingglass",
                    description: Text(
                        AppStrings.Home.emptyDescription
                    )
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(
                            viewModel.filteredLoans,
                            id: \.name
                        ) { loan in
                            LoanCard(
                                loan: loan,
                                colors: colors,
                                fonts: fonts
                            )
                        }
                    }
                    .padding(.vertical, 6)
                }
                .refreshable {
                    await viewModel.loadLoans()
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .background(
            colors.background
                .ignoresSafeArea()
        )
        .navigationTitle(
            AppStrings.Home.navigationTitle
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(
                placement: .topBarTrailing
            ) {
                Button(
                    AppStrings.Home.logout
                ) {
                    Task {
                        await viewModel.logout()
                    }
                }
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .presentationState(
            viewModel: viewModel
        )
    }
}
