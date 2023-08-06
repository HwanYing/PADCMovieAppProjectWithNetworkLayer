//
//  CheckOutView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI

struct CheckOutView: View {
    
    let mModel: MovieModel = MovieModelImpl.shared

    @State var ticketCount = 1

    @State var ticketPolicyShow = false
    @State var showPayment: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var showBeverage: Bool = true
    @State var cancelPrice = 0
    @State var showTotalPrice = 0
    
    @State var checkOutSuccess: Bool = false
    @State var date1: String = ""
    @State var time = ""
    @State var ticketPrice: Int = 0
    @State var finalTotalPrice: Int = 0
    
    var timeslotId: Int?
    var seatNumber: [String]?
    var seatPrice: Int?
    var bookingDate: String?
    var bookingTime: String?
    var movieId: Int?
    var cardId: Int?
    var snacks: [SnackRequest]?
    var movieTitle: String?
    @Binding var snackTotalPrice: Int
    @Binding var snackList: [SnackDetailsVO]?
    var posterImagelink: String?
    var place: String?
    
    var body: some View {
        ZStack {
            // Background color
            Color(BG_COLOR)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    // App Bar Section
                    CheckOutAppbarView(){
                        dismiss()
                    }
                    .padding(.top, MARGIN_XXLARGE + MARGIN_MEDIUM_1)
                    
                    // Check Info Section
                    VStack(alignment: .leading,spacing: 0.0) {
                        // MovieTitle section
                        MovieTitleSectionView(title: self.movieTitle)
                        
                        // cinema place, screen no.
                        CinemaPlaceScreenView(place: place)
                        
                        // Date, time , place
                        DateTimePlaceCombineView(date: self.bookingDate, startTime: self.bookingTime, place: place)
                        
                        // no of ticket
                        NumberOfTicketSectionView(ticketCount: self.seatNumber?.count ?? 0)
                        
                        // tiket info section
                        TicketInfoSectionView(ticketName: self.seatNumber, ticketPrice: self.ticketPrice)
                        
                        Divider()
                            .background(Color(SUB_TEXT_COLOR))
                            .padding(.top, MARGIN_MEDIUM_4)
                        
                        // food and beverage title
                        FoodAndBeverageTitleView(showBeverage: $showBeverage, totalPrice: self.showTotalPrice)
                        
                        // food and beverage section
                        FoodListView(expandBeverage: showBeverage, snacks: self.snackList){ snackId, categoryid, snackName, qty in
                            self.snackList = snackList?.map({ snack in
                                if (snack.id == snackId && snack.categoryID == categoryid) {
                                    self.cancelPrice = snack.price ?? 0
                                    return SnackDetailsVO(id: snack.id, name: snack.name, description: snack.description, price: snack.price, categoryID: snack.categoryID, image: snack.image, selectCount: 0)
                                } else {
                                    return SnackDetailsVO(id: snack.id, name: snack.name, description: snack.description, price: snack.price, categoryID: snack.categoryID, image: snack.image, selectCount: snack.selectCount)
                                }
                            })
                            self.snackTotalPrice = self.snackTotalPrice - (self.cancelPrice*qty)
                            print(self.snackTotalPrice)
                            self.showTotalPrice = 0
                            self.showTotalPrice = self.snackTotalPrice * 1000
                            print("Show Total Price change ==> \(self.showTotalPrice)")
                        }
                        
                        VStack(alignment: .leading, spacing: 0.0) {
                            
                            // Dash divider
                            DashedLineView()
                            
                            // convenience fee title
                            ConvenienceFeeTitleView()
                            
                            // ticket policy section
                            TicketPolicySectionView(ticketPolicyShow: $ticketPolicyShow)
                            
                            Divider()
                                .background(Color(SUB_TEXT_COLOR))
                                .padding(.top, MARGIN_XLARGE - 2)
                            
                            // Final Total section
                            FinalTotalView(finalTotal: self.finalTotalPrice)
                        }
                        
                        
                        
                    }
                    .padding([.leading,.trailing], MARGIN_LARGE)
                    .frame(width: UIScreen.main.bounds.width - MARGIN_SXLARGE)
                    .padding(.top, MARGIN_XLARGE)
                    .background(cardBgColor)
                    .cornerRadius(MARGIN_MEDIUM)
                    
                    // continue button
                        BottomFloatingBtnView(text: CONTINUE_BTN_LABEL)
                            .padding(.top, MARGIN_MEDIUM)
                            .onTapGesture {
                                self.checkOutSuccess = true
                            }
                        Spacer()
                }
            }
            
            TicketCancelationPolicyView(showDialog: $ticketPolicyShow)
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $checkOutSuccess, destination: {
            PaymentPageVeiw(timeslotId: self.timeslotId, seatNumber: self.seatNumber, seatPrice: self.seatPrice, bookingDate: self.bookingDate, movieId: self.movieId, snackList: self.snackList, totalSeatPrice: self.seatPrice, movieTitle: self.movieTitle, snackTotalPrice: self.snackTotalPrice, posterImageLink: self.posterImagelink, place: self.place)
        })
        .onAppear(){
            print("Movie Title ===> \(self.movieTitle ?? "")")
            print("Poster image ==> \(posterImagelink ?? "")")
            self.showTotalPrice = self.snackTotalPrice * 1000
            self.ticketPrice = (self.seatPrice ?? 0) * 1000
            print("Ticket price ==> \(self.ticketPrice)")
            print("Snack total price ==> \(self.showTotalPrice)")
            self.finalTotalPrice = self.ticketPrice + self.showTotalPrice + 500
        }
        .onChange(of: self.snackTotalPrice) { newValue in
            print("New Value ==> \(newValue)")
            self.showTotalPrice = newValue * 1000
            self.finalTotalPrice = self.showTotalPrice + self.ticketPrice + 500
        }
    }
    
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(snackTotalPrice: .constant(0), snackList: .constant([SnackDetailsVO]()))
    }
}

struct CheckOutAppbarView: View {
    
    var onTapBack: () -> Void = {}
    
    var body: some View {
        HStack {
            // back icon
            Image(systemName: IC_CHEV_LEFT)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_LARGE - 2)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding([.leading, .trailing], MARGIN_LARGE)
                .onTapGesture {
                    // TODO: Navigate back
                    onTapBack()
                }
            Spacer()
            
            // title
            Text(CHECK_OUT_TITLE)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_LARGE - 2))
                .fontWeight(.bold)
                .padding(.leading, -MARGIN_XXLARGE)
            
            Spacer()
        }
        .padding(.top, MARGIN_MEDIUM)
    }
}

struct DateTimePlaceSectionView: View {
    
    var image: String
    var value: String
    var textSize: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: MARGIN_SMALL) {
            // icon image
            Image(systemName: image)
                .resizable()
                .frame(width: MARGIN_MEDIUM_4, height: MARGIN_MEDIUM_4)
                .foregroundColor(Color(PRIMARY_COLOR))
            
            // value
            Text(value)
                .font(.system(size: textSize))
                .foregroundColor(.white)
                .padding(.top, MARGIN_MEDIUM_1)
        }
    }
}

struct FoodAndBeverageListView: View {
    
    var foodName: String
    var qty: Int
    var price: Int
    var onCancelSnack: ((String, Int) -> Void)?

    var body: some View {
        HStack {
            Image(systemName: IC_MULTIPLY_RETURN)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2, height: MARGIN_CARD_MEDIUM_2 + 1)
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.bold)
                .onTapGesture {
                    guard let onCancelSnack = onCancelSnack else { return }
                    onCancelSnack(foodName, qty)
                }
            
            Text("\(foodName)(Qt.\(qty))")
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .fontWeight(.bold)
            
            Spacer()
            
            Text("\(price)000 Ks")
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .fontWeight(.bold)
        }
        .padding(.top, MARGIN_MEDIUM_2)
    }
}
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
struct HalfCircleView1: View {
    
    var widthAndHeight: CGFloat
    var color: String
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.5)
            .fill(Color(color))
            .frame(width: widthAndHeight, height: widthAndHeight)
    }
}

struct MovieTitleSectionView: View {
    
    var title: String?
    
    var body: some View {
        HStack {
            Text(title ?? "")
                .font(.system(size: MARGIN_MEDIUM_3))
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Text("(\(MOVIE_WATCHING_TYPE))(\(MOVIE_RATING_CONTENT))")
                .font(.system(size: MARGIN_MEDIUM_2))
                .padding(.leading, -MARGIN_SMALL)
            
            
            
        }
        .font(.system(size: MARGIN_MEDIUM_2))
        .foregroundColor(.white)
    }
}

struct CinemaPlaceScreenView: View {
    
    var place: String?
    
    var body: some View {
        HStack {
            Text(place ?? "")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.semibold)
            
//            Text("(SCREEN 2)")
//                .font(.system(size: MARGIN_HALF_LARGE))
//                .fontWeight(.semibold)
//                .foregroundColor(Color(SUB_TEXT_COLOR))
        }
        .padding(.top, MARGIN_MEDIUM_1)
    }
}

struct DateTimePlaceCombineView: View {
    
    var date: String?
    var startTime: String?
    var place: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: MARGIN_XLARGE - 2) {
            DateTimePlaceSectionView(image: IC_CALENDAR_NORMAL, value: date ?? "", textSize: MARGIN_HALF_LARGE)
            
            DateTimePlaceSectionView(image: IC_CLOCK, value: startTime ?? "", textSize: MARGIN_HALF_LARGE)
            
            DateTimePlaceSectionView(image: IC_LOCATION_UNFILL, value: place ?? "", textSize: MARGIN_CARD_MEDIUM_2)
        }
        .padding(.top, MARGIN_XLARGE)
    }
}

struct NumberOfTicketSectionView: View {
    
    var ticketCount: Int
    
    var body: some View {
        HStack {
            Text("M-Ticket(")
                .foregroundColor(.white)
            Text("\(ticketCount)")
                .foregroundColor(Color(PRIMARY_COLOR))
                .padding([.leading, .trailing], -MARGIN_SMALL)
            Text(")")
                .foregroundColor(.white)
        }
        .font(.system(size: MARGIN_HALF_LARGE))
        .padding(.top, MARGIN_XLARGE)
    }
}

struct TicketInfoSectionView: View {
    
    var ticketName: [String]?
    var ticketPrice: Int?
    @State var ticketNameString = ""
    
    var body: some View {
        HStack{
            Text(ticketNameString)
            Spacer()
            Text("\(ticketPrice ?? 0) Ks")
        }
        .font(.system(size: MARGIN_MEDIUM_2))
        .foregroundColor(.white)
        .fontWeight(.bold)
        .padding(.top, MARGIN_MEDIUM_1)
        .onAppear(){
            
            self.ticketNameString = ticketName?.map({
                $0
            }).joined(separator: ",") ?? ""
        }
    }
}

struct FoodAndBeverageTitleView: View {
    
    @Binding var showBeverage: Bool
    @State var icon = IC_CHEV_UP
    var totalPrice: Int?
    
    var body: some View {
        HStack {
            Image(FOOD_AND_BEVERAGE_IMG)
                .resizable()
                .frame(width: MARGIN_MEDIUM_4 + 2, height: MARGIN_MEDIUM_4)
            
            Text(FOOD_AND_BEVERAGE_TITLE)
                .font(.system(size: MARGIN_MEDIUM_3))
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Image(systemName: showBeverage ? icon : IC_CHEV_DOWN)
                .resizable()
                .frame(width: MARGIN_MEDIUM_1, height: MARGIN_MEDIUM)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .onTapGesture {
                    showBeverage.toggle()
                }
            
            Spacer()
            
            Text("\(totalPrice ?? 0) Ks")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding(.top, MARGIN_MEDIUM_4)
    }
}

struct FoodListView: View {
    
    var expandBeverage: Bool
    var snacks: [SnackDetailsVO]?
    var onCancelSnack: ((Int, Int, String, Int) -> Void)?

    var body: some View {
        
        if expandBeverage {
            VStack(alignment: .leading, spacing: 0.0) {
                ForEach(snacks ?? [], id: \.id) { snack in
                    if (snack.selectCount != 0) {
                        FoodAndBeverageListView(foodName: snack.name ?? "", qty: snack.selectCount, price: snack.price ?? 0){ snackName, qty in
                            guard let onCancelSnack = onCancelSnack else { return }
                            onCancelSnack(snack.id ?? 0, snack.categoryID ?? 0, snackName, qty)
                        }
                    }
                   
                }
//                FoodAndBeverageListView(foodName: "Potato Chips", qty: 1, price: 1000)
//                FoodAndBeverageListView(foodName: "Cocacola Large", qty: 1, price: 1000)
            }
            .padding(.top, MARGIN_MEDIUM)
        }
    }
}

struct DashedLineView: View {
    var body: some View {
        ZStack {
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [MARGIN_MEDIUM - 2]))
                .frame(height: 1)
                .foregroundColor(Color(SUB_TEXT_COLOR).opacity(0.5))
            
            HStack {
                HalfCircleView1(widthAndHeight: MARGIN_SXLARGE, color: BG_COLOR)
                    .rotationEffect(Angle(degrees: -CIRCLE_ROTATE_DEGREE))
                Spacer()
                
                HalfCircleView1(widthAndHeight: MARGIN_SXLARGE, color: BG_COLOR)
                    .rotationEffect(Angle(degrees: CIRCLE_ROTATE_DEGREE))
            }
            .padding([.leading, .trailing], -MARGIN_SXLARGE - MARGIN_SMALL)
            
        }
        .padding(.top, MARGIN_MEDIUM_2)
    }
}

struct ConvenienceFeeTitleView: View {
    var body: some View {
        HStack{
            Text(CONVENIENCE_FEE_TITLE)
                .font(.system(size: MARGIN_MEDIUM_3))
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Image(systemName: IC_CHEV_DOWN)
                .resizable()
                .frame(width: MARGIN_MEDIUM_1, height: MARGIN_MEDIUM)
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("500Ks")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding(.top, MARGIN_MEDIUM_2)
    }
}

struct TicketPolicySectionView: View {
    
    @Binding var ticketPolicyShow: Bool
    
    var body: some View {
        HStack{
            Image(systemName: IC_INFO_CIRCLE)
                .foregroundColor(.white)
            
            Text(TICKET_CANCELING_POLICY)
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(.white)
            
        }
        .padding([.top, .bottom],MARGIN_SMALL)
        .padding([.leading, .trailing], MARGIN_MEDIUM)
        .background(Color(COLOR_CANCEL))
        .cornerRadius(MARGIN_MEDIUM_4)
        .padding(.top, MARGIN_MEDIUM_4)
        .onTapGesture {
            withAnimation {
                ticketPolicyShow = true
            }
        }
    }
}

struct FinalTotalView: View {

    var finalTotal: Int?
    @State var totalPrice: Int = 0
    
    var body: some View {
        HStack{
            // Total label
            Text(TOTAL_LABEL)
            
            Spacer()
            
            // Total Price
            Text("\(finalTotal ?? 0) Ks")
        }
        .font(.system(size: MARGIN_MEDIUM_3))
        .foregroundColor(Color(PRIMARY_COLOR))
        .fontWeight(.bold)
        .padding(.bottom, MARGIN_LARGE)
        .padding(.top, MARGIN_MEDIUM_3)
        
    }
}
