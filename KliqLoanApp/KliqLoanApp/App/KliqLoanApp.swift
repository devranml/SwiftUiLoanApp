//
//  KliqLoanApp.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

@main
struct KliqLoanApp: App {
    private let dependencies =
        AppDependencies()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                dependencies: dependencies
            )
        }
    }
}
