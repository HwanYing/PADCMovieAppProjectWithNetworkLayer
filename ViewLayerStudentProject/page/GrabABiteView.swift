//
//  GrabABiteView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI

struct GrabABiteView: View {
    
    //    @State var snacks: [SnackTypeVO] = snackFilterType
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let mModel: MovieModel = MovieModelImpl.shared
    let uModel: UserModel = UserModelImpl.shared
    @State var itemCount = 1
    //    @Binding var grabAbite: Bool
    @Environment(\.dismiss) var dismiss
    @State var filterSheet = false
    @State var image = IC_CHEV_DOWN
    var seatName: [String]?
    var price: Int?
    var slotID: Int?
    @State var categories: [SnackCategoryVO]? = nil
    @State var snacks: [SnackDetailsVO]? = nil
    @State var token : String = ""
    @State var count: Int = 0
    @State var totalPrice: Int = 0
    
    var body: some View {
        ZStack {
            // Background color
            Color(BG_COLOR)
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                VStack(alignment: .leading, spacing: 0.0) {
                    
                    // App Bar section
                    AppBarSectionView(){
                        dismiss()
                    }
                  
                    // SnackType section
                    SnackTypeSectionView(categories: categories){ categoryId in
                        categories = categories?.map({ selected in
                            if selected.id == categoryId {
                                let category = SnackCategoryVO(id: selected.id, title: selected.title, isSelected: true)
                                print("is selected \(categoryId) \(selected.isSelected ?? false)")
return category
                            } else {
                                return SnackCategoryVO(id: selected.id, title: selected.title, isSelected: false)
                            }
                        })
                        self.getSnacksByID(id: categoryId)
                    }
                    
                    // Snack Grid list section
                    SnackGridView(snacks: snacks, count: $count, totalPrice: $totalPrice).padding(.top, MARGIN_MEDIUM_2)
                    
                }
                .padding(.top, FOOTER_PADDING)
                
                // SNACK count bottom view
                //                if filterSheet {
                //                    FoodItemCountSheet()
                //                        .onTapGesture {
                //                            self.filterSheet.toggle()
                //                        }
                //                } else {
//                NavigationLink(value: ViewOptionsRoute.checkout) {
                    SnackCountBottomView(itemCount: $itemCount, image: IC_CHEV_DOWN, filterSheet: $filterSheet, totalPrice: $totalPrice)
//                }
                
                //
                //                }
                
            }
            .sheet(isPresented: $filterSheet, content: {
                FoodItemCountSheet()
                
            })
            .navigationBarBackButtonHidden(true)
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .onAppear(){
            print("seat name ==> \(seatName ?? [])")
            print("slot id ==> \(slotID ?? 0)")
            print("Price ===> \(price ?? 0)")
            requestData()
        }
    }
    func requestData() {
        mModel.getSnackCategories() { categories in
            self.categories = categories
        } onFailure: { error in
            debugPrint(error)
        }
        self.getSnacksByID(id: 0)
    }
    func getSnacksByID(id: Int){
        
        mModel.getSnackListByCategory(id: id) { snacks in
            self.snacks = snacks
        } onFailure: { error in
            debugPrint(error)
        }
        
        
    }
}

struct GrabABiteView_Previews: PreviewProvider {
    static var previews: some View {
        GrabABiteView()
    }
}

struct AppBarSectionView: View {
    
    var onTapBack: () -> Void = {}
    
    var body: some View {
        HStack {
            // back icon
            Image(systemName: IC_CHEV_LEFT)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_LARGE - 2)
                .padding(.leading, MARGIN_LARGE - 2)
                .onTapGesture {
                    // TODO: Navigate Back
                    onTapBack()
                }
            // title
            Text(GRAB_A_BITE_LABEL)
                .font(.system(size: MARGIN_LARGE - 2))
                .padding(.leading, MARGIN_XLARGE)
            
            Spacer()
            
            // search icon
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: MARGIN_LARGE - 2, height: MARGIN_LARGE - 2)
                .padding(.trailing, MARGIN_LARGE)
            
            // skip label
            Text(SKIP_LABEL)
                .font(.system(size: MARGIN_MEDIUM_4))
                .padding(.trailing, MARGIN_MEDIUM_4)
        }
        .foregroundColor(.white)
        .fontWeight(.bold)
    }
}

struct SnackTypeSectionView: View {
    
    var categories: [SnackCategoryVO]?
    var onTapCategory: ((Int) -> Void)?
    @State var isSelected: Bool = true
    
    var body: some View {
        if categories?.isEmpty ?? false {
           EmptyView()
        } else {
            ScrollView(.horizontal) {
                HStack {
                    VStack {
                        Text( "ALL")
                            .font(.system(size: MARGIN_MEDIUM_2))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding([.leading, .trailing], MARGIN_MEDIUM)
                        
                        Rectangle()
                            .fill(self.isSelected ? Color(PRIMARY_COLOR) : .clear)
                            .frame(height: 3)
                    }
                    .onTapGesture {
                        guard let onTapCategory = self.onTapCategory else { return }
                        self.isSelected = true
                        onTapCategory(0)
                        
                    }
                    ForEach(categories ?? [], id: \.id) { category in
                        VStack {
                            Text(category.titleMM ?? "ALL")
                                .font(.system(size: MARGIN_MEDIUM_2))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding([.leading, .trailing], MARGIN_MEDIUM)
                            
                            Rectangle()
                                .fill(category.isSelected ?? false ? Color(PRIMARY_COLOR) : .clear)
                                .frame(height: 3)
                        }
                        .onTapGesture {
                            guard let onTapCategory = self.onTapCategory else { return }
                            self.isSelected = false
                            onTapCategory(category.id ?? 0)
                            
                        }
                    }
                }
                .padding(EdgeInsets(top: MARGIN_XLARGE, leading: MARGIN_MEDIUM, bottom: 0, trailing: MARGIN_MEDIUM))
            }

        }
    }
}

struct ItemCountView: View {
    
    @Binding var itemCount: Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            
            Circle()
                .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_CARD_MEDIUM_2)
                .foregroundColor(.red)
            
            // Item count text
            Text("\(itemCount)")
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM))
            
        })
    }
}

struct SnackItemShowView: View {
    
    @Binding var itemCount: Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
            Image(SNACK_COUNT_IMAGE)
                .resizable()
                .frame(width: MARGIN_LARGE + MARGIN_SMALL, height: GG_Size)
            
            // item count circle view
            ItemCountView(itemCount: $itemCount)
                .padding(.trailing, -MARGIN_MEDIUM)
            
        }
    }
}

struct SnackCountBottomView: View {
    
    @Binding var itemCount: Int
    var image: String
    @Binding var filterSheet: Bool
    @Binding var totalPrice: Int
    
    var body: some View {
        VStack {
            HStack{
                // Snack item count view
                SnackItemShowView(itemCount: $itemCount)
                
                Image(systemName: image)
                    .resizable()
                    .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_MEDIUM)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.leading, MARGIN_HALF_LARGE)
                    .onTapGesture {
                        self.filterSheet.toggle()
                    }
                
                Spacer()
                
                // total price
                Text("\(totalPrice)Ks")
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                Image(systemName: IC_CHEV_RIGHT)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM, height: MARGIN_HALF_LARGE)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.leading, MARGIN_MEDIUM_1)
            }
            .padding()
            .background(Color(PRIMARY_COLOR))
            .cornerRadius(MARGIN_MEDIUM_1)
            .padding([.leading, .trailing], MARGIN_MEDIUM_2)
            
        }
        .frame(minHeight: 0, maxHeight: SNACK_ITEM_WIDTH)
        .background(Color(.black))
        .onAppear(){
            print("Total Price \(self.totalPrice)")
            print("Item count \(self.itemCount)")
        }
    }
}
