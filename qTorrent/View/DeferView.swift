//
//  DeferView.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/28/22.
//

import SwiftUI

struct DeferView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        content()
    }
}
