//
//  TicketView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI

struct TicketView: View {
        
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Color(BG_COLOR)
                
                VStack(alignment: .leading, spacing: 0) {
                    // Appbar
                    TicketAppBarView()
                        .padding(.top, MARGIN_XXLARGE + MARGIN_MEDIUM_2)
                    
                    // list of ticket booking
                    TicketRecordListView()
                    
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea([.top, .bottom])
            .navigationDestination(for: Int.self) { _ in
                TicketCancelingView()
            }
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}

struct TicketAppBarView: View {
    var body: some View {
        HStack(spacing: MARGIN_LARGE){
            
            Spacer()
            
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: TEXT_SMALL_HEADING, height: TEXT_SMALL_HEADING)
            
            Image(systemName: IC_NOTIFICATION)
                .resizable()
                .frame(width: MARGIN_MEDIUM_3, height: MARGIN_MEDIUM_4)
            
            Image(systemName: IC_SCAN_FINDER)
                .resizable()
                .frame(width: MARGIN_MEDIUM_4 + 1, height: MARGIN_MEDIUM_4 + 1)
        }
        .foregroundColor(.white)
        .fontWeight(.bold)
        .padding(.trailing, MARGIN_MEDIUM_4)
    }
}

struct TicketCardView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(BOOKING_BG_COLOR_2).opacity(0.4), Color(BOOKING_BG_COLOR_3).opacity(0.7), Color(SNACK_BG_COLOR)], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack(alignment: .leading, spacing: 0.0){
                // Ticket info
                TicketInfoView()
                    .padding(.top, MARGIN_MEDIUM_3)
                
                // dash line and half circle
                LineView()
                
                // Date, time , place
                DateTimePlaceSubView()
            }
        }
        .frame(width: TICKET_WIDTH, height: TICKET_HEIGHT)
        .cornerRadius(MARGIN_MEDIUM)
        .padding([.leading, .trailing])
    }
}

struct LineView: View {
    var body: some View {
        ZStack {
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [MARGIN_MEDIUM_2 / 2]))
                .frame(height: 1)
                .foregroundColor(Color(SECTION_ICON_COLOR))
            
            HStack {
                HalfCircleView1(widthAndHeight: MARGIN_SXLARGE, color: BG_COLOR)
                    .rotationEffect(Angle(degrees: -CIRCLE_ROTATE_DEGREE))
                Spacer()
                
                HalfCircleView1(widthAndHeight: MARGIN_SXLARGE, color: BG_COLOR)
                    .rotationEffect(Angle(degrees: CIRCLE_ROTATE_DEGREE))
            }
            .padding([.leading, .trailing], -MARGIN_MEDIUM_4)
            
        }
        .padding(.top, MARGIN_MEDIUM_2)
    }
}

struct TicketInfoView: View {
    var body: some View {
        HStack(spacing: MARGIN_MEDIUM_3){
            Image(POSTER_IMAGE)
                .resizable()
                .frame(width: BOOKING_RESULT_IMG_WIDTH, height: BOOKING_RESULT_IMG_HEIGHT)
                .cornerRadius(MARGIN_SMALL)
            
            VStack(alignment: .leading,spacing: MARGIN_CARD_MEDIUM_2){
                HStack {
                    Text(MOVIE_TITLE)
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    Text("(\(MOVIE_WATCHING_TYPE))")
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .foregroundColor(Color(SUB_NOTE_COLOR))
                        .padding([.leading, .trailing], -MARGIN_SMALL)
                    
                    Text("(\(MOVIE_RATING_CONTENT))")
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .foregroundColor(Color(SUB_NOTE_COLOR))
                        .padding([.leading, .trailing], -MARGIN_SMALL)
                }
                
                Text(CINEMA_NAME)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .fontWeight(.bold)
                
                HStack {
                    Text("\(M_TICKET)")
                        .font(.system(size: MARGIN_HALF_LARGE))
                        .foregroundColor(Color(SUB_TEXT_COLOR))
                    
                    Text("\(2)")
                        .font(.system(size: MARGIN_HALF_LARGE))
                        .foregroundColor(Color(PRIMARY_COLOR))
                        .padding([.leading, .trailing], -MARGIN_SMALL)
                    Text(")")
                        .font(.system(size: MARGIN_HALF_LARGE))
                        .foregroundColor(Color(SUB_TEXT_COLOR))
                }
                HStack {
                    Text(TICKET_SEAT_NO)
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Text(SCREEN_NUMBER)
                        .font(.system(size: MARGIN_CARD_MEDIUM_2))
                        .foregroundColor(Color(SUB_TEXT_COLOR))
                }
            }
            Spacer()
        }
        .padding(.leading, MARGIN_MEDIUM_2)
    }
}

struct DateTimePlaceSubView: View {
    var body: some View {
        HStack(alignment: .top,spacing: MARGIN_LARGE){
            DateTimePlaceSectionView(image: IC_CALENDAR_NORMAL, value: "Wed, May 17, 2023", textSize: MARGIN_CARD_MEDIUM_2)
                .frame(width: TICKET_PLACE_FRAME_WIDTH)
            
            DateTimePlaceSectionView(image: IC_CLOCK, value: "12:14 PM", textSize: MARGIN_CARD_MEDIUM_2)
            
            DateTimePlaceSectionView(image: IC_LOCATION, value: "Q5H3+JPP,Corner of,Bogyoke Lann,Yangon", textSize: MARGIN_CARD_MEDIUM_2)
                .frame(width: TICKET_PLACE_FRAME_WIDTH)
        }
        .padding([.leading, .trailing], MARGIN_LARGE)
        .padding(.bottom, MARGIN_XLARGE)
    }
}

struct TicketRecordListView: View {
    var body: some View {
        ForEach(0..<2) { number in
            NavigationLink(value: number) {
                TicketCardView()
                    .padding(.top, MARGIN_LARGE)
            }
        }
    }
}
