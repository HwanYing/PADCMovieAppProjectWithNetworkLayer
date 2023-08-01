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
    // snackId
    var onAddSnack: ((Int, Int) -> Void)?
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: MARGIN_MEDIUM_4) {
                ForEach(snacks ?? [], id: \.id) { item in
                    SnackCardView(snackItems: item, count: $count, totalPrice: $totalPrice){ snackId, categoryId in
                        print("Snack Id \(snackId)")
                        print("Category Id \(categoryId)")
                        guard let onAddSnack = onAddSnack else { return }
                        onAddSnack(snackId, categoryId)
                    }
                }
            }
            .padding([.leading, .trailing], MARGIN_MEDIUM_1)
            .padding(.top, MARGIN_CARD_MEDIUM_2)
        }
        .padding(.bottom, TICKET_PLACE_FRAME_WIDTH)
    }
}

struct SnackGridView_Previews: PreviewProvider {
    static var previews: some View {
        SnackGridView(count: .constant(0), totalPrice: .constant(0))
    }
}
struct SnackImageView: View {
    
    var imageUrl: String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)){ phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, idealWidth: SNACK_ITEM_WIDTH, maxWidth: SNACK_ITEM_WIDTH, minHeight: 0, idealHeight: SNACK_ITEM_WIDTH, maxHeight: SNACK_ITEM_WIDTH)
                    .clipped()

            case .failure:
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                EmptyView()
            }
        }
        
    }
}
