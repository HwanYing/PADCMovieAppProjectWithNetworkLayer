//
//  TabBarItem.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import SwiftUI

struct TabBarItem: View {
    
    @Binding var current: Page
    var title: Page
    var image: String
    
    var body: some View {
        Button(action: {
            current = title
        }, label: {
            VStack{
                Image(systemName: image)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(current == title ? Color(PRIMARY_COLOR) : Color(SUB_TEXT_COLOR))
                
                Text(title.rawValue)
                    .fontWeight(.bold)
                    .font(.system(size: MARGIN_CARD_MEDIUM_2))
                    .foregroundColor(current == title ? Color(PRIMARY_COLOR) : Color(SUB_TEXT_COLOR))
                
            }
            .padding(.top, 10)
            .padding(.horizontal)
            
        })
    }
}
