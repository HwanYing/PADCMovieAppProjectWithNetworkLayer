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
    
    @State var checkOutResult: CheckOutVO? = nil
    @State var checkOutSuccess: Bool = false
    
    var timeslotId: Int?
    var seatNumber: [String]?
    var seatPrice: Int?
    var bookingDate: String?
    var movieId: Int?
    var cardId: Int?
    var snacks: [SnackRequest]?
    var movieTitle: String?
    var snackTotalPrice: Int?
    var snackList: [SnackDetailsVO]?
    var posterImagelink: String?
    
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
                        CinemaPlaceScreenView(place: self.checkOutResult?.bookingNo)
                        
                        // Date, time , place
                        DateTimePlaceCombineView(date: checkOutResult?.bookingDate, startTime: checkOutResult?.timeslot?.startTime, place: checkOutResult?.bookingNo)
                        
                        // no of ticket
                        NumberOfTicketSectionView(ticketCount: ticketCount)
                        
                        // tiket info section
                        TicketInfoSectionView(ticketName: self.seatNumber?.first, ticketPrice: self.seatPrice)
                        
                        Divider()
                            .background(Color(SUB_TEXT_COLOR))
                            .padding(.top, MARGIN_MEDIUM_4)
                        
                        // food and beverage title
                        FoodAndBeverageTitleView(showBeverage: $showBeverage, totalPrice: self.snackTotalPrice)
                        
                        // food and beverage section
                        FoodListView(expandBeverage: showBeverage, snacks: self.snackList)
                        
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
                            FinalTotalView(seatPrice: self.seatPrice, snackPrice: self.snackTotalPrice, fee: 5)
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
        .fullScreenCover(isPresented: $checkOutSuccess, content: {
            TicketInformationConfirmView(movieTitle: self.movieTitle, place: checkOutResult?.bookingNo, ticketName: self.seatNumber?.first, date: self.bookingDate, startTime: checkOutResult?.timeslot?.startTime, posterImageLink: "")
        })
        .onAppear(){
            print("Movie Title ===> \(self.movieTitle ?? "")")
            requestData()
        }
    }
    
    func requestData() {
        mModel.fetchCheckOut(timeslotId: self.timeslotId ?? 0, seatNumber: self.seatNumber ?? [], bookingDate: self.bookingDate ?? "", movieId: self.movieId ?? 0, cardId: self.cardId ?? 0, snacks: self.snacks ?? []) { result in
            self.checkOutResult = result
        } onFailure: { error in
            print(error)
        }

    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
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
    
    var body: some View {
        HStack {
            Image(systemName: IC_MULTIPLY_RETURN)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2, height: MARGIN_CARD_MEDIUM_2 + 1)
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.bold)
            
            Text("\(foodName)(Qt.\(qty))")
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .fontWeight(.bold)
            
            Spacer()
            
            Text("\(price)Ks")
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
    
    var ticketName: String?
    var ticketPrice: Int?
    
    var body: some View {
        HStack{
            Text(ticketName ?? "")
            Spacer()
            Text("\(ticketPrice ?? 0)Ks")
        }
        .font(.system(size: MARGIN_MEDIUM_2))
        .foregroundColor(.white)
        .fontWeight(.bold)
        .padding(.top, MARGIN_MEDIUM_1)
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
            
            Text("\(totalPrice ?? 0)Ks")
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
    
    var body: some View {
        
        if expandBeverage {
            VStack(alignment: .leading, spacing: 0.0) {
                ForEach(snacks ?? [], id: \.id) { snack in
                    if (snack.selectCount != 0) {
                        FoodAndBeverageListView(foodName: snack.name ?? "", qty: snack.selectCount, price: snack.price ?? 0)
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
            
            Text("5Ks")
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
    
    var seatPrice: Int?
    var snackPrice: Int?
    var fee: Int?
    @State var totalPrice: Int = 0
    
    var body: some View {
        HStack{
            // Total label
            Text(TOTAL_LABEL)
            
            Spacer()
            
            // Total Price
            Text("\(totalPrice)Ks")
        }
        .font(.system(size: MARGIN_MEDIUM_3))
        .foregroundColor(Color(PRIMARY_COLOR))
        .fontWeight(.bold)
        .padding(.bottom, MARGIN_LARGE)
        .padding(.top, MARGIN_MEDIUM_3)
        .onAppear(){
            self.totalPrice = (seatPrice ?? 0) + (snackPrice ?? 0)  + (fee ?? 0)
        }
    }
}
