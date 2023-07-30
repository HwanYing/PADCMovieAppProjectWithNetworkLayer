//
//  DateBackgroundView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/12.
//

import SwiftUI

struct DateBackgroundView: View {
    
    var isSelected: Bool?
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            // Background
            Rectangle()
                .cornerRadius(MARGIN_MEDIUM)
                .foregroundColor(isSelected ?? false ? Color(PRIMARY_COLOR) : Color(DAY_BG_COLOR))
                .padding([.leading, .trailing], MARGIN_MEDIUM_1)
            
            // Top Bar
            VStack{
                Color.black
                    .frame(width: MARGIN_LARGE - 2, height: MARGIN_SMALL)
                    .cornerRadius(2)
                    .padding(.bottom, MARGIN_XBIG + MARGIN_SMALL + 1)
            }
            // Semi circles
            HStack{
                Circle()
                    .frame(width: MARGIN_MEDIUM_4, height: MARGIN_MEDIUM_2)
                    .foregroundColor(Color(BG_COLOR))
                
                Spacer()
                
                Circle()
                    .frame(width: MARGIN_MEDIUM_4, height: MARGIN_MEDIUM_2)
                    .foregroundColor(Color(BG_COLOR))
            }
            .padding(.bottom, MARGIN_HALF_LARGE)
        }
        .frame(width: MARGIN_XBIG + MARGIN_MEDIUM - 1, height: MARGIN_XBIG + MARGIN_MEDIUM_2 - 1)

    }
}

struct DateBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        DateBackgroundView(isSelected: false)
    }
}
