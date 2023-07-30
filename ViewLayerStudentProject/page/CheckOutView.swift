//
//  CheckOutView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI

struct CheckOutView: View {
    
    @State var ticketCount = 1

    @State var ticketPolicyShow = false
    @State var showPayment: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var showBeverage: Bool = true
    
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
                        MovieTitleSectionView()
                        
                        // cinema place, screen no.
                        CinemaPlaceScreenView()
                        
                        // Date, time , place
                        DateTimePlaceCombineView()
                        
                        // no of ticket
                        NumberOfTicketSectionView(ticketCount: ticketCount)
                        
                        // tiket info section
                        TicketInfoSectionView()
                        
                        Divider()
                            .background(Color(SUB_TEXT_COLOR))
                            .padding(.top, MARGIN_MEDIUM_4)
                        
                        // food and beverage title
                        FoodAndBeverageTitleView(showBeverage: $showBeverage)
                        
                        // food and beverage section
                        FoodListView(expandBeverage: showBeverage)
                        
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
                            FinalTotalView()
                        }
                        
                        
                        
                    }
                    .padding([.leading,.trailing], MARGIN_LARGE)
                    .frame(width: UIScreen.main.bounds.width - MARGIN_SXLARGE)
                    .padding(.top, MARGIN_XLARGE)
                    .background(cardBgColor)
                    .cornerRadius(MARGIN_MEDIUM)
                    
                    // continue button
                    NavigationLink(value: ViewOptionsRoute.payment) {
                        
                        BottomFloatingBtnView(text: CONTINUE_BTN_LABEL)
                            .padding(.top, MARGIN_MEDIUM)
                    }
                    Spacer()
                }
            }
            
            TicketCancelationPolicyView(showDialog: $ticketPolicyShow)
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        
        .navigationBarBackButtonHidden(true)
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
    var body: some View {
        HStack {
            Text(MOVIE_TITLE)
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
    var body: some View {
        HStack {
            Text("JCGV: Junction City")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.semibold)
            
            Text("(SCREEN 2)")
                .font(.system(size: MARGIN_HALF_LARGE))
                .fontWeight(.semibold)
                .foregroundColor(Color(SUB_TEXT_COLOR))
        }
        .padding(.top, MARGIN_MEDIUM_1)
    }
}

struct DateTimePlaceCombineView: View {
    
    var body: some View {
        HStack(alignment: .top, spacing: MARGIN_XLARGE - 2) {
            DateTimePlaceSectionView(image: IC_CALENDAR_NORMAL, value: "Sun, 7 May, 2023", textSize: MARGIN_HALF_LARGE)
            
            DateTimePlaceSectionView(image: IC_CLOCK, value: "21:49 PM", textSize: MARGIN_HALF_LARGE)
            
            DateTimePlaceSectionView(image: IC_LOCATION_UNFILL, value: "Q5H3+JPP,Corner of, Bogyoke Lann, Yangon", textSize: MARGIN_CARD_MEDIUM_2)
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
    var body: some View {
        HStack{
            Text("Gold-G8,G7")
            Spacer()
            Text("20000Ks")
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
            
            Text("2000Ks")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding(.top, MARGIN_MEDIUM_4)
    }
}

struct FoodListView: View {
    
    var expandBeverage: Bool
    
    var body: some View {
        
        if expandBeverage {
            VStack(alignment: .leading, spacing: 0.0) {
                FoodAndBeverageListView(foodName: "Potato Chips", qty: 1, price: 1000)
                FoodAndBeverageListView(foodName: "Cocacola Large", qty: 1, price: 1000)
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
    var body: some View {
        HStack{
            // Total label
            Text(TOTAL_LABEL)
            
            Spacer()
            
            // Total Price
            Text("22500Ks")
        }
        .font(.system(size: MARGIN_MEDIUM_3))
        .foregroundColor(Color(PRIMARY_COLOR))
        .fontWeight(.bold)
        .padding(.bottom, MARGIN_LARGE)
        .padding(.top, MARGIN_MEDIUM_3)
    }
}
