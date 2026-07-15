//
//  LoadingOverlay.swift
//  KliqLoanApp
//
//  Created by Machine Dev on 14.07.2026.
//

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.15)
                .ignoresSafeArea()

            ProgressView()
                .padding(20)
                .background(.white)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 12
                    )
                )
        }
    }
}
