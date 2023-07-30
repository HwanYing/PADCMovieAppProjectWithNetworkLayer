//
//  BackButtonSubView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/22.
//

import SwiftUI

struct BackButtonSubView: View {
    var body: some View {
        Image(systemName: IC_CHEV_LEFT)
            .resizable()
            .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_LARGE - 2)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .clipped()
            .padding([.leading, .trailing], MARGIN_LARGE)
            
    }
}

struct BackButtonSubView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonSubView()
    }
}
