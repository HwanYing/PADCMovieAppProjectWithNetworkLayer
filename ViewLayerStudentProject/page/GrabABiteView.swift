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
    @State var totalItemCount = 0
    //    @Binding var grabAbite: Bool
    @Environment(\.dismiss) var dismiss
    @State var filterSheet = false
    @State var image = IC_CHEV_DOWN
    @State var categories: [SnackCategoryVO]? = allSnackDataCategory
    @State var allSnacks: [SnackDetailsVO]? = nil
    @State var snacksByType: [SnackDetailsVO]? = nil
    
    @State var token : String = ""
    @State var totalPrice: Int = 0
    @State var categoryTab: Int = 0
    // Bottom Sheet
    @State var itemNames: [Int: String]? = [:]
    @State var itemsCount: [Int: Int]? = [:]
    @State var itemsPrice: [Int: Int]? = [:]
    @State var snackId: [Int]? = []
    
    @State var goToCheckOut: Bool = false
    
    var timeslotId: Int?
    var seatNumber: [String]?
    var totalSeatPrice: Int?
    var bookingDate: String?
    var bookingTime: String?
    var movieId: Int?
    var movieTitle: String?
    var posterImageLink: String?
    var place: String?
    
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
                    SnackTypeSectionView(categories: self.categories){ categoryId in
                        print("Original categories \(categories ?? [])")
                        let newCategories = categories?.map({ selected in
                            if selected.id == categoryId {
                                return SnackCategoryVO(id: categoryId, title: selected.title, titleMM: selected.titleMM, isActive: 1, createdAt: "", updatedAt: "", isSelected: true)
                            } else {
                                return SnackCategoryVO(id: selected.id, title: selected.title, titleMM: selected.titleMM, isActive: 1, createdAt: "", updatedAt: "", isSelected: false)
                            }
                        })
                        self.categories = nil
                        print(self.categories ?? [])
                        self.categories = newCategories
                        
                        self.snacksByType = allSnacks
                        self.categoryTab = categoryId
                        
                        if (categoryId == 0) {
                            self.snacksByType = allSnacks
                        } else {
                            snacksByType = snacksByType?.filter({
                                $0.categoryID == categoryId
                            })
                        }
                       
                    }
                    
                    // Snack Grid list section
                    SnackGridView(snacks: snacksByType, totalCount: $totalItemCount, totalPrice: $totalPrice){ snackId, categoryId, itemCount in
                        let snackWithNewCount = allSnacks?.map({ iteratedSnack in
                            
                            if (iteratedSnack.id == snackId && iteratedSnack.categoryID == categoryId) {
                                
                                return SnackDetailsVO(id: iteratedSnack.id, name: iteratedSnack.name, description: iteratedSnack.description, price: iteratedSnack.price, categoryID: iteratedSnack.categoryID, image: iteratedSnack.image, selectCount: itemCount)
                                //  var unitPrice: Int?
//                                var quantity: Int?
//                                var totalPrice: Int?
                            } else {
                                
                                if (iteratedSnack.selectCount > 0 && iteratedSnack.id != snackId) {
                                    
                                    print("Iterated count \(iteratedSnack.selectCount)")
                                    
                                    return SnackDetailsVO(id: iteratedSnack.id, name: iteratedSnack.name, description: iteratedSnack.description, price: iteratedSnack.price, categoryID: iteratedSnack.categoryID, image: iteratedSnack.image, selectCount: iteratedSnack.selectCount)
                                    
                                }
                                
                                return SnackDetailsVO(id: iteratedSnack.id, name: iteratedSnack.name, description: iteratedSnack.description, price: iteratedSnack.price, categoryID: iteratedSnack.categoryID, image: iteratedSnack.image, selectCount: 0)
                                
                            }
                        })
                        self.snacksByType = nil
                        print(snackWithNewCount ?? [])
                        self.allSnacks = snackWithNewCount

                        if (self.categoryTab == 0) {
                            self.snacksByType = allSnacks
                        } else {
                            snacksByType = snackWithNewCount?.filter({
                                $0.categoryID == self.categoryTab
                            })
                        }
                    }
                    
                }
                .padding(.top, FOOTER_PADDING)
                .onTapGesture {
                    self.filterSheet.toggle()
                }
               
                if !filterSheet {
                    SnackCountBottomView(itemCount: $totalItemCount, image: IC_CHEV_DOWN, filterSheet: $filterSheet, totalPrice: $totalPrice, itemsCount: self.itemsCount)
                        .frame(minHeight: 0, maxHeight: SNACK_ITEM_WIDTH)
                        .onTapGesture {
                            self.goToCheckOut = true
                        }
                    
                } else {
                    
                    FoodItemCountSheet(totalCount: $totalItemCount, totalPrice: $totalPrice, filterSheet: $filterSheet, snacks: self.allSnacks) { snackId, categoryId, itemCount in
                        let snackWithNewCount = allSnacks?.map({ iteratedSnack in
                        
                            
                            if (iteratedSnack.id == snackId && iteratedSnack.categoryID == categoryId) {
                                
                                return SnackDetailsVO(id: iteratedSnack.id, name: iteratedSnack.name, description: iteratedSnack.description, price: iteratedSnack.price, categoryID: iteratedSnack.categoryID, image: iteratedSnack.image, selectCount: itemCount)
                                
                            } else {
                                
                                if (iteratedSnack.selectCount > 0 && iteratedSnack.id != snackId) {
                                    
                                    print("Iterated count \(iteratedSnack.selectCount)")
                                    
                                    return SnackDetailsVO(id: iteratedSnack.id, name: iteratedSnack.name, description: iteratedSnack.description, price: iteratedSnack.price, categoryID: iteratedSnack.categoryID, image: iteratedSnack.image, selectCount: iteratedSnack.selectCount)
                                    
                                }
                                
                                return SnackDetailsVO(id: iteratedSnack.id, name: iteratedSnack.name, description: iteratedSnack.description, price: iteratedSnack.price, categoryID: iteratedSnack.categoryID, image: iteratedSnack.image, selectCount: 0)
                                
                            }
                        })
                        self.snacksByType = nil
                        print(snackWithNewCount ?? [])
                        self.allSnacks = snackWithNewCount
                   
                        
                        if (self.categoryTab == 0) {
                            self.snacksByType = allSnacks
                        } else {
                            snacksByType = snackWithNewCount?.filter({
                                $0.categoryID == self.categoryTab
                            })
                        }
                    }

                }
               
            }
            .navigationBarBackButtonHidden(true)
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationDestination(isPresented: $goToCheckOut, destination: {
            CheckOutView(timeslotId: self.timeslotId, seatNumber: self.seatNumber, seatPrice: self.totalSeatPrice, bookingDate: self.bookingDate, bookingTime: self.bookingTime, movieId: self.movieId, movieTitle: self.movieTitle, snackTotalPrice: $totalPrice, snackList: $allSnacks, posterImagelink: self.posterImageLink, place: self.place)
        })
        .onAppear(){
            print("seat name ==> \(seatNumber ?? [])")
            print("slot id ==> \(timeslotId ?? 0)")
            print("Price ===> \(totalSeatPrice ?? 0)")
            requestData()
        }
    }
    func requestData() {
        mModel.getSnackCategories() { categories in
       
            self.categories?.append(contentsOf: categories)
            print(self.categories ?? [])
            
        } onFailure: { error in
            debugPrint(error)
        }
        self.getSnacksByID(id: 0)
    }
    func getSnacksByID(id: Int){
        
        mModel.getSnackListByCategory(id: id) { snacks in
            self.allSnacks = snacks
            self.snacksByType = snacks
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
    
    var body: some View {
        if categories?.isEmpty ?? false {
           EmptyView()
        } else {
            ScrollView(.horizontal) {
                HStack {
//                    VStack {
//                        Text( "ALL")
//                            .font(.system(size: MARGIN_MEDIUM_2))
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .padding([.leading, .trailing], MARGIN_MEDIUM)
//
//                        Rectangle()
//                            .fill(self.isSelected ? Color(PRIMARY_COLOR) : .clear)
//                            .frame(height: 3)
//                    }
//                    .onTapGesture {
//                        guard let onTapCategory = self.onTapCategory else { return }
//                        self.isSelected = true
//                        onTapCategory(0)
//
//                    }
                    ForEach(categories ?? [], id: \.id) { category in
                        VStack {
                            Text(category.titleMM ?? "")
                                .font(.system(size: MARGIN_MEDIUM_2))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding([.leading, .trailing], MARGIN_MEDIUM)
                            
                            Rectangle()
                                .fill(category.isSelected ? Color(PRIMARY_COLOR) : .clear)
                                .frame(height: 3)
                        }
                        .onTapGesture {
                            guard let onTapCategory = self.onTapCategory else { return }
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
    
    var itemCount: Int?
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            
            Circle()
                .frame(width: MARGIN_MEDIUM_2, height: MARGIN_MEDIUM_2)
                .foregroundColor(.red)
            
            // Item count text
            Text("\(itemCount ?? 0)")
                .foregroundColor(.white)
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
            
        })
    }
}

struct SnackItemShowView: View {
    
    var itemCount: Int?
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
            Image(SNACK_COUNT_IMAGE)
                .resizable()
                .frame(width: MARGIN_LARGE + MARGIN_SMALL, height: GG_Size)
            
            // item count circle view
            ItemCountView(itemCount: itemCount)
                .padding(.trailing, -MARGIN_MEDIUM)
            
        }
    }
}

struct SnackCountBottomView: View {
    
    @Binding var itemCount: Int
    var image: String
    @Binding var filterSheet: Bool
    @Binding var totalPrice: Int
    
    var itemsCount: [Int: Int]?

    var body: some View {
        VStack {
            HStack{
                // Snack item count view
                SnackItemShowView(itemCount: itemCount)
                
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
                Text("\(totalPrice)000 Ks")
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
        .background(Color(.black))
        .onAppear(){
            print("Total Price \(self.totalPrice)")
            print("Item count \(self.itemCount)")
            
//            getItemsWithCount()
        }
    }
    
//    func getItemsWithCount() {
//        for data in itemsCount ?? [:]{
//            self.itemCount = data.value
//        }
//    }
}
