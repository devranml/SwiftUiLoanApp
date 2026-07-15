//
//  AppRoute.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 15.07.2026.
//


enum AppRoute: String, Hashable, Identifiable {
    case login
    case home

    var id: String {
        rawValue
    }
}

enum PresentationStyle {
    case root
    case push
    case sheet
    case fullScreenCover
}
