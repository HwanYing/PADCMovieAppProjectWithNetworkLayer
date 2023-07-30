//
//  SnackGridView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI

struct SnackGridView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var snacks: [SnackDetailsVO]?
    @Binding var count: Int
    @Binding var totalPrice: Int
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: MARGIN_MEDIUM_4) {
                ForEach(snacks ?? [], id: \.id) { item in
                    SnackCardView(snackItems: item, count: $count, totalPrice: $totalPrice)
                }
            }
            .padding([.leading, .trailing], MARGIN_MEDIUM_1)
        }

    }
}

struct SnackGridView_Previews: PreviewProvider {
    static var previews: some View {
        SnackGridView(count: .constant(0), totalPrice: .constant(0))
    }
}
