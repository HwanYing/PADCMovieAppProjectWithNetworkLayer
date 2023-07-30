//
//  FoodItemCountSheet.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/10.
//

import SwiftUI

struct FoodItemCountSheet: View {
    
    @State var itemCount = 1
    @State var itemPrice = 1000
    
    var body: some View {
      
        ZStack {
            Color(.black)
            
            VStack(alignment: .leading, spacing: 0.0){
                ItemListDetailsView(itemName: "Large Cola", itemCount: $itemCount, itemPrice: $itemPrice)
                    .padding(.bottom, MARGIN_MEDIUM_2)
                    .padding(.trailing, MARGIN_LARGE)
                
                ItemListDetailsView(itemName: "Potatoes Chips", itemCount: $itemCount, itemPrice: $itemPrice)
                    .padding(.trailing, MARGIN_LARGE)

                // SNACK count bottom view
//                SnackCountBottomView(itemCount: $itemCount, image: IC_CHEV_UP, filterSheet: .constant(false))
//                    .padding(.bottom, -MARGIN_LARGE)

            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width) // height: ITEM_COUNT_SHEET_HEIGHT
        .roundedCorner(MARGIN_MEDIUM_4, corners: [.topLeft, .topRight])
        .edgesIgnoringSafeArea(.bottom)

    }
}

struct FoodItemCountSheet_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemCountSheet()
    }
}

struct ItemListDetailsView: View {
    
    var itemName: String
    @Binding var itemCount: Int
    @Binding var itemPrice: Int
    
    var body: some View {
        HStack {
            // Item name
            Text("\(itemName)")
                .foregroundColor(.white)
                .font(.system(size: MARGIN_HALF_LARGE))
                .fontWeight(.bold)
                .padding(.leading, MARGIN_MEDIUM_4)
            
            Spacer()
            
            // item count section
            HStack {
                Image(systemName: IC_PLUS_CIRCLE_FILL)
                    .foregroundColor(Color(PRIMARY_COLOR))
                Text("\(itemCount)")
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .font(.system(size: MARGIN_HALF_LARGE))
                Image(systemName: IC_MINUS_CIRCLE_FILL)
                    .foregroundColor(Color(PRIMARY_COLOR))
            }
            .padding(.trailing, MARGIN_XLARGE)
           
           
            
            Text("\(itemPrice)Ks")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
