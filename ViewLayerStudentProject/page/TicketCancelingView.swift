//
//  TicketCancelingView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/22.
//

import SwiftUI

struct TicketCancelingView: View {
    
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
                    // app bar view
                    TicketCancelAppBarView(){
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
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Refund Amount")
                                .font(.system(size: MARGIN_MEDIUM_2))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            Text("15000Ks")
                                .font(.system(size: MARGIN_MEDIUM_4))
                                .foregroundColor(Color(COLOR_CANCEL))
                                .fontWeight(.bold)
                                .padding(.top, MARGIN_MEDIUM)
                        }
                        .padding(.leading, MARGIN_MEDIUM_4)
                        
                        Spacer()
                        
                        // cancel booking section
                        CancelBookingBtnView(text: "Cancel Booking")
                            .padding(.trailing, MARGIN_MEDIUM_1)
                    }
                    .padding(.top, MARGIN_MEDIUM_1)
                    
                    Spacer()
                }
            }
            
            TicketCancelationPolicyView(showDialog: $ticketPolicyShow)
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        
        .navigationBarBackButtonHidden(true)
    }
}

struct TicketCancelingView_Previews: PreviewProvider {
    static var previews: some View {
        TicketCancelingView()
    }
}

// app bar view
struct TicketCancelAppBarView: View{
    
    var onTapBack: () -> Void = {}
    
    var body: some View{
        HStack{
            //back icon
           BackButtonSubView()
                .onTapGesture {
                    onTapBack()
                }
            
            Spacer()
            
            Text(TICKET_DETAILS_TITLE)
                .font(.system(size: MARGIN_LARGE - 2))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.leading, -MARGIN_XXLARGE)
            
            Spacer()
        }
    }
}

// cancel booking section
struct CancelBookingBtnView: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            
            Text(text)
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding()
                .frame(width: TICKET_CANCEL_BTN_WIDTH, height: BOOKING_BTN_HEIGHT)
                .background(Color(COLOR_CANCEL))
                .cornerRadius(MARGIN_MEDIUM_1)
            
            HStack {
                
                HalfCircleView(widthAndHeight: MARGIN_MEDIUM_4)
                    .rotationEffect(Angle(degrees: -CIRCLE_ROTATE_DEGREE))
                
                Spacer()
                
                HalfCircleView(widthAndHeight: MARGIN_MEDIUM_4)
                    .rotationEffect(Angle(degrees: CIRCLE_ROTATE_DEGREE))
            }
            .frame(width: TICKET_CANCEL_BTN_WIDTH + MARGIN_MEDIUM_4)
        }
    }
}
