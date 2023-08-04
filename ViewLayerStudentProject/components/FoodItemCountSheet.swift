//
//  FoodItemCountSheet.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/10.
//

import SwiftUI

struct FoodItemCountSheet: View {
    
    @Binding var totalCount: Int
    @State var rowCount = 0
//    @State var itemPrice: [Int]? = []
//    @State var itemName: [String]? = []
//
//    @State var price1 = 0
//    @State var count1 = 0
    @Binding var totalPrice: Int
    @Binding var filterSheet: Bool
//    var itemNames: [Int: String]?
//    var itemsCount: [Int: Int]?
//    var itemsPrice: [Int: Int]?
    var snacks: [SnackDetailsVO]?
    // snackId
    var onAddSnack: ((Int, Int, Int) -> Void)?
    
    var body: some View {
      
        ZStack {
            Color(.black)
            
            
            VStack(alignment: .leading, spacing: 0.0){
                VStack{
                    ForEach(snacks ?? [], id: \.id) { item in
                        if (item.selectCount != 0) {
                            ItemListDetailsView(totalItemCount: $totalCount, snackItems: item, totalPrice: $totalPrice)
                            { snackId, categoryId, itemCount in
                                print("Snack Id \(snackId)")
                                print("Category Id \(categoryId)")
                                print("Snack Count \(itemCount)")
                                guard let onAddSnack = onAddSnack else { return }
                                onAddSnack(snackId, categoryId, itemCount)
                            }
                            .onAppear(){
                                self.rowCount += 1
                            }
                        }
                        
                    }

                }
                .padding(.top, MARGIN_MEDIUM_1)
//                ForEach(0..<(self.itemCount?.count ?? 0), id: \.self) { number in
//
//                    ItemListDetailsView(itemName: itemName?[number] ?? "", itemCount: $count1, itemPrice: $price1)
//                        .onAppear(){
//                            self.price1 = itemPrice?[number] ?? 0
//                            self.count1 = itemCount?[number] ?? 0
//                        }
//                }
//                ItemListDetailsView(itemName: "Large Cola", itemCount: $itemCount, itemPrice: $itemPrice)
//                    .padding(.bottom, MARGIN_MEDIUM_2)
//                    .padding(.trailing, MARGIN_LARGE)
//
//                ItemListDetailsView(itemName: "Potatoes Chips", itemCount: $itemCount, itemPrice: $itemPrice)
//                    .padding(.trailing, MARGIN_LARGE)

                // SNACK count bottom view
                SnackCountBottomView(itemCount: $totalCount, image: IC_CHEV_UP, filterSheet: $filterSheet, totalPrice: $totalPrice)
                    .frame(height: SNACK_ITEM_WIDTH - MARGIN_MEDIUM_1)
                    .padding(.top, -MARGIN_MEDIUM_2)
            }
            .frame(width: UIScreen.main.bounds.width, height: Double(self.rowCount)*MARGIN_SXLARGE+SNACK_ITEM_WIDTH)
        }
        .frame(width: UIScreen.main.bounds.width,  height: Double(self.rowCount)*MARGIN_SXLARGE+SNACK_ITEM_WIDTH) // height: ITEM_COUNT_SHEET_HEIGHT
        .roundedCorner(MARGIN_MEDIUM_4, corners: [.topLeft, .topRight])
        .edgesIgnoringSafeArea(.bottom)
//        .onAppear(){
//            debugPrint(itemsCount ?? [])
//            for data in itemNames ?? [:] {
//                if (itemsCount?[data.key] ?? 0 > 0) {
//                    let name1 = itemNames?[data.key] ?? ""
//                    let count1 = itemsCount?[data.key] ?? 0
//                    let price1 = itemsPrice?[data.key] ?? 0
//                    
//                    if (!(itemName?.contains(name1) ?? true)) {
//                        self.itemName?.append(itemNames?[data.key] ?? "")
//                    }
//                    if (!(itemCount?.contains(count1) ?? true)) {
//                        self.itemCount?.append(itemsCount?[data.key] ?? 0)
//
//                    }
//                    if (!(itemPrice?.contains(price1) ?? true)) {
//                        self.itemPrice?.append(itemsPrice?[data.key] ?? 0)
//                    }
//                }
//
//            }
//            debugPrint(self.itemName ?? [])
//            debugPrint(self.itemCount ?? [])
//            debugPrint(self.itemPrice ?? [])
//
//        }

    }
}

struct FoodItemCountSheet_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemCountSheet(totalCount: .constant(0), totalPrice: .constant(0), filterSheet: .constant(false))
    }
}

struct ItemListDetailsView: View {
    
//    var itemName: String
    @Binding var totalItemCount: Int
//    @Binding var itemPrice: Int
    @State var snackCount = 0
    var snackItems: SnackDetailsVO?
    @Binding var totalPrice: Int
    // snackId
    var onAddSnack: ((Int, Int, Int) -> Void)?
    
    var body: some View {
        HStack {
            // Item name
            HStack {
                Text("\(snackItems?.name ?? "")")
                    .foregroundColor(.white)
                    .font(.system(size: MARGIN_HALF_LARGE))
                    .fontWeight(.bold)
                    .padding(.leading, MARGIN_MEDIUM_4)
                
                Spacer()
            }
            .frame(width: (UIScreen.main.bounds.width / 2) - MARGIN_MEDIUM_2)
                        
            Spacer()
            // item count section
            HStack {
                Image(systemName: IC_PLUS_CIRCLE_FILL)
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .onTapGesture {
                        self.snackCount += 1
                        self.totalPrice += snackItems?.price ?? 0
                        self.totalItemCount += 1
                    }
                
                Text("\(snackItems?.selectCount ?? 0)")
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .font(.system(size: MARGIN_HALF_LARGE))
                
                Image(systemName: IC_MINUS_CIRCLE_FILL)
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .onTapGesture {
                        if (self.snackCount > 0) {
                            self.snackCount -= 1
                            self.totalPrice -= snackItems?.price ?? 0
                            self.totalItemCount -= 1
                        } else {
                            self.snackCount = 0
                            self.totalPrice = 0
                            self.totalItemCount = 0
                        }
                      
                    }
            }
            .frame(width: TIME_SLOT_WIDTH)
           
             Spacer()
            Text("\(snackItems?.price ?? 0)Ks")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.trailing, MARGIN_MEDIUM_2)
        }
        .frame(height: MARGIN_SXLARGE)
        .onAppear(){
            self.snackCount = snackItems?.selectCount ?? 0
        }
        .onChange(of: self.snackCount) { newValue in
            print("Receive Here count for this item \(newValue)")
            guard let onAddSnack = onAddSnack else { return }
            onAddSnack(snackItems?.id ?? 0, snackItems?.categoryID ?? 0, self.snackCount)
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
