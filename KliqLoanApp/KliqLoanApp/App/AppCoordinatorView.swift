//
//  AppCoordinatorView.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator:
        AppCoordinator

    @State private var didConfigureInitialRoute = false

    private let dependencies:
        AppDependencies

    @MainActor
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies

        _coordinator = StateObject(
            wrappedValue: AppCoordinator()
        )
    }

    var body: some View {
        NavigationStack(
            path: $coordinator.path
        ) {
            rootContent
                .navigationDestination(
                    for: AppRoute.self
                ) { route in
                    buildView(for: route)
                }
        }
        .sheet(
            item: $coordinator.sheetRoute
        ) { route in
            NavigationStack {
                buildView(for: route)
            }
        }
        .fullScreenCover(
            item: $coordinator.fullScreenRoute
        ) { route in
            NavigationStack {
                buildView(for: route)
            }
        }
        .tint(dependencies.colors.primary)
        .task {
            configureInitialRouteIfNeeded()
        }
    }

    @ViewBuilder
    private var rootContent: some View {
        if let rootRoute = coordinator.rootRoute {
            buildView(for: rootRoute)
        } else {
            ProgressView()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
        }
    }

    @ViewBuilder
    private func buildView(
        for route: AppRoute
    ) -> some View {
        switch route {
        case .login:
            makeLoginView()

        case .home:
            makeHomeView()
        }
    }

    private func makeLoginView() -> LoginView {
        LoginView(
            viewModel:
                dependencies.makeLoginViewModel(
                    onLoginSuccess: {
                        coordinator.showAsPush(.home)
                    }
                ),
            colors: dependencies.colors,
            fonts: dependencies.fonts
        )
    }

    private func makeHomeView() -> HomeView {
        HomeView(
            viewModel:
                dependencies.makeHomeViewModel(
                    onLogoutSuccess: {
                        handleLogout()
                    }
                ),
            colors: dependencies.colors,
            fonts: dependencies.fonts
        )
    }

    private func configureInitialRouteIfNeeded() {
        guard !didConfigureInitialRoute else {
            return
        }

        didConfigureInitialRoute = true

        let isLoggedIn =
            dependencies.isSessionActive()

        coordinator.configureInitialRoute(
            isLoggedIn: isLoggedIn
        )
    }

    private func handleLogout() {
        /*
         Login root iken Home push edilmişse:
         Login → Home
         logout → popToRoot → Login
         */
        if coordinator.rootRoute == .login {
            coordinator.popToRoot()
        } else {
            /*
             Uygulama kayıtlı session ile açıldıysa
             Home doğrudan root olur. Bu durumda
             geri dönülecek Login ekranı yoktur.
             */
            coordinator.showAsRoot(.login)
        }
    }
}
