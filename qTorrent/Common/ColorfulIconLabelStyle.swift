//
//  ColorfulIconLabelStyle.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/29/22.
//

import SwiftUI

struct ColorfulIconLabelStyle: LabelStyle {
    var color: Color
    var size: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
                .padding(.leading, 5)
        } icon: {
            configuration.icon
                .imageScale(.medium)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 7 * size).frame(width: 28 * size, height: 28 * size).foregroundColor(color))
        }
    }
}
