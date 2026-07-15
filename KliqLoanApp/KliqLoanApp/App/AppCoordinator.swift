//
//  AppCoordinator.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var rootRoute: AppRoute?
    @Published var path: [AppRoute] = []

    @Published var sheetRoute: AppRoute?
    @Published var fullScreenRoute: AppRoute?

    func configureInitialRoute(isLoggedIn: Bool) {
        showAsRoot(
            isLoggedIn ? .home : .login
        )
    }

    func showAsRoot(_ route: AppRoute) {
        rootRoute = route
        path.removeAll()
        sheetRoute = nil
        fullScreenRoute = nil
    }

    func showAsPush(_ route: AppRoute) {
        path.append(route)
    }

    func showAsSheet(_ route: AppRoute) {
        sheetRoute = route
    }

    func showAsFullScreenCover(_ route: AppRoute) {
        fullScreenRoute = route
    }

    func pop() {
        guard !path.isEmpty else {
            return
        }

        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func dismissSheet() {
        sheetRoute = nil
    }

    func dismissFullScreenCover() {
        fullScreenRoute = nil
    }
}
