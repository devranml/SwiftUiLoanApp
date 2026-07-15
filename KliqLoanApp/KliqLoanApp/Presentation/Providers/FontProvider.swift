//
//  FontProvider.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

protocol FontProviding {
    var heading: Font { get }
    var body: Font { get }
    var input: Font { get }
    var button: Font { get }
    var caption: Font { get }
    var badge: Font { get }
    var amount: Font { get }
}

struct AppFontProvider: FontProviding {
    let heading = Font.system(
        size: 22,
        weight: .bold
    )

    let body = Font.system(
        size: 15,
        weight: .regular
    )

    let input = Font.system(
        size: 16,
        weight: .regular
    )

    let button = Font.system(
        size: 16,
        weight: .bold
    )

    let caption = Font.system(
        size: 12,
        weight: .regular
    )

    let badge = Font.system(
        size: 10,
        weight: .bold
    )

    let amount = Font.system(
        size: 18,
        weight: .bold
    )
}
