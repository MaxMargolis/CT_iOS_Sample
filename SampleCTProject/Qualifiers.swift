//
//  Qualifiers.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 6/3/25.
//

import SwiftUI
import CleverTapSDK

struct Qualifiers: View {
    var body: some View {
        Button {
            CleverTap.sharedInstance()?.recordEvent("Qualify For Red Segment")
        } label: {
            Text("Qualify For Red Segment")
                .foregroundStyle(.red)
                .fontWeight(.bold)
        }

    }
}

#Preview {
    Qualifiers()
}
