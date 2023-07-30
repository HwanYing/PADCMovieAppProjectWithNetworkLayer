//
//  SnackCardView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI

struct SnackCardView: View {
    
    @State var addSnack = false
    var snackItems: SnackDetailsVO?
    @State var snackName: String = ""
    @State var price: Int = 0

    @Binding var count: Int
    @Binding var totalPrice: Int
    
    var body: some View {
        ZStack{
            // Card Bg color
         LinearGradient(gradient: Gradient(colors: [Color(TITLE_LABEL_COLOR), Color(SNACK_BG_COLOR)]), startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 0.0) {
                // Snack Image
                Image(SWEET_POTATO_IMAGE)
                    .resizable()
                    .frame(width: SNACK_ITEM_WIDTH, height: SNACK_ITEM_WIDTH)
                    .padding([.leading, .trailing], GG_Size)
                
                // Snack name
                Text("\(snackName)")
                    .foregroundColor(.white)
                    .font(.system(size: MARGIN_CARD_MEDIUM_2))
                    .fontWeight(.semibold)
                    .padding(.top, MARGIN_MEDIUM_2)
                    .padding(.leading, MARGIN_MEDIUM_1)
                
                // Snack price
                Text("\(price)KS")
                    .font(.system(size: MARGIN_CARD_MEDIUM_2))
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .fontWeight(.semibold)
                    .padding(.top, MARGIN_SMALL)
                    .padding(.leading, MARGIN_MEDIUM_1)
                
                if (addSnack && self.count > 0) {
                    // Add snack item view
                    AddItemSectionView(snackCount: $count, totalPrice: $totalPrice, itemPrice: $price )
                        
                } else {
                    Button(action: {
                        self.count = 0
                        addSnack = true
                    }, label: {
                        Text(ADD_BTN_LABEL)
                            .foregroundColor(.black)
                            .font(.system(size: MARGIN_HALF_LARGE))
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: MARGIN_SMALL, leading: MARGIN_XLARGE, bottom: MARGIN_SMALL, trailing: MARGIN_XLARGE))
                    })
                    .frame(width: SNACK_CARD_WIDTH - MARGIN_MEDIUM_4)
                    .background(Color(PRIMARY_COLOR))
                    .cornerRadius(MARGIN_SMALL)
                    .padding(.all, MARGIN_MEDIUM_1)
                }
              
            }
        }
        .frame(width: SNACK_CARD_WIDTH, height: SNACK_CARD_HEIGHT)
        .cornerRadius(MARGIN_MEDIUM)
        .onAppear(){
            self.snackName = snackItems?.name ?? ""
            self.price = snackItems?.price ?? 0
            print("Item price \(price)")
        }
    }
}

struct SnackCardView_Previews: PreviewProvider {
    static var previews: some View {
        SnackCardView(count: .constant(0), totalPrice: .constant(0))
            .previewLayout(.fixed(width: SNACK_CARD_WIDTH, height: SNACK_CARD_HEIGHT))
    }
}

// Add snack item view
struct AddItemSectionView: View {
    
    @Binding var snackCount: Int
    @Binding var totalPrice: Int
    @Binding var itemPrice: Int
    
    var body: some View {
        HStack{
            Spacer()
            // plus icon
            Image(systemName: IC_PLUS_CIRCLE_FILL)
                .resizable()
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                .foregroundColor(Color(PRIMARY_COLOR))
                .clipped()
                .onTapGesture {
                    self.snackCount += 1
                    self.totalPrice += self.itemPrice
                }
            
            Text("\(snackCount+1)")
                .font(.system(size: MARGIN_MEDIUM_3))
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.bold)
            
            // minus icon
            Image(systemName: IC_MINUS_CIRCLE_FILL)
                .resizable()
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                .foregroundColor(Color(PRIMARY_COLOR))
                .clipped()
                .onTapGesture {
                    if (self.snackCount > 1) {
                        self.snackCount -= 1
                        self.totalPrice -= self.itemPrice
                    } else {
                        self.snackCount = 0
                        self.totalPrice = 0
                    }
                }
        }
        .frame(width: SNACK_CARD_WIDTH - MARGIN_MEDIUM_4)
        .padding([.trailing, .top, .bottom], MARGIN_MEDIUM_1)
    }
}
