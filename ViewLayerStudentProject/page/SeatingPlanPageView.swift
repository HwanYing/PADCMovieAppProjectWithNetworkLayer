//
//  SeatingPlanPageView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/14.
//

import SwiftUI

struct SeatingPlanPageView: View {
    
    @Environment(\.presentationMode) var presentation
    let mModel: MovieModel = MovieModelImpl.shared
    let uModel: UserModel = UserModelImpl.shared
    
    var date: Date?
    var slotId: Int?
    var movieId: Int?
    var movieTitle: String?
    var posterImageLink: String?
    
    @State var seats : [CinemaSeatVO]? = nil
    @State var seatId: [String] = []
    @State var seatPrice: Int = 0
    @State var selectSeatComplete: Bool = false
    @State var computedDate = ""
    @State var seatName: [String] = []
    @State var seatItemPrice: Int = 0
    @State var changedSeats: [CinemaSeatVO]? = nil
    @State var selectCount = 0
    
    var body: some View {
        ZStack {
            
            Color(BG_COLOR)
            
            VStack(spacing: 0.0) {
                // Appbar
                SeatingPlanAppBarView(){
                    presentation.wrappedValue.dismiss()
                }
                
                // Screen
                CinemaScreenView()
                    .padding(.top, MARGIN_MEDIUM_2)
                
                // Price
                Text(PRICE_NORMAL_TEXT)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(SUB_TEXT_COLOR))
                    .padding(.bottom, MARGIN_MEDIUM)
                
                
                // Movie Seat
                MovieSeatZoomableContainerView(view: AnyView(MovieSeatsView(seatArray: self.seats, seatId: $seatId, seatName: $seatName, seatPrice: $seatPrice, seatItemPrice: $seatItemPrice)
                                                             { seatCustomId in
                    self.changedSeats = seats?.map({ iteratedSeat in
                        if (iteratedSeat.uniqueId == seatCustomId) {
                            
                            return CinemaSeatVO(id: iteratedSeat.id, type: iteratedSeat.type, seatName: iteratedSeat.seatName, symbol: iteratedSeat.symbol, price: iteratedSeat.price, isSelected: true)
                            
                        } else if (iteratedSeat.isSelected) {
                            
                            return CinemaSeatVO(id: iteratedSeat.id, type: iteratedSeat.type, seatName: iteratedSeat.seatName, symbol: iteratedSeat.symbol, price: iteratedSeat.price, isSelected: true)
                            
                        } else {
                            
                            return CinemaSeatVO(id: iteratedSeat.id, type: iteratedSeat.type, seatName: iteratedSeat.seatName, symbol: iteratedSeat.symbol, price: iteratedSeat.price, isSelected: false)
                            
                        }
                        
                    })
                    print(self.changedSeats ?? CinemaSeatVO())
                    self.seats = nil
                    self.seats = self.changedSeats
                    
                }
                                                            ), viewHeight: SEAT_VIEW_HEIGHT, seatId: seatId, price: seatPrice, isSelected: $selectSeatComplete).padding([.leading, .trailing], MARGIN_SMALL)
                
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $selectSeatComplete, content: {
//            var timeslotId: Int?
//            var seatNumber: [String]?
//            var totalSeatPrice: Int?
//            var bookingDate: String?
//            var movieId: Int?
            GrabABiteView(timeslotId: self.slotId, seatNumber: self.seatName, seatPrice: self.seatItemPrice, totalSeatPrice: self.seatPrice, bookingDate: self.computedDate, movieId: self.movieId, movieTitle: self.movieTitle, posterImageLink: self.posterImageLink)
        })
        .onAppear(){
            self.computedDate = self.calculatedDate(date: date ?? Date())
            
            requestData(slotId: slotId ?? 0, date: computedDate)
        }
    }
    
    func calculatedDate(date: Date) -> String {
        print("selected date ==> \(date)")
        print("Slot id ==> \(slotId ?? 0)")
        
        let df = DateFormatter()
        df.dateFormat = "YY/MM/dd"
        
        let result = df.string(from: date)
        let dayString = result.split(separator: ",")[0]
        let computedDate = dayString.replacingOccurrences(of: "/", with: "-")
        
        return computedDate
    }
    
    func requestData(slotId: Int, date: String) {
        mModel.getSeatingPlanByShowTime(timeSlotID: slotId, date: date) { seats in
            self.seats = seats
        } onFailure: { error in
            print(error)
        }
        
    }
}

struct SeatingPlanPageView_Previews: PreviewProvider {
    static var previews: some View {
        SeatingPlanPageView()
    }
}
// Appbar
struct SeatingPlanAppBarView: View {
    
    var onTapBack: () -> Void = {}
    
    var body: some View {
        HStack {
            Image(systemName: IC_CHEV_LEFT)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_LARGE - 2)
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Spacer()
        }
        .padding([.leading, .trailing], MARGIN_MEDIUM_4)
        .padding(.top, MARGIN_XBIG - MARGIN_MEDIUM)
        .onTapGesture {
            onTapBack()
        }
    }
}

// Screen
struct CinemaScreenView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Image(CINEMA_SCREEN_IMG)
                .resizable()
                .frame(width: CINEMA_SCREEN_WIDTH, height: CINEMA_SCREEN_HEIGHT)
                .clipped()
            
            Text(SCREEN_TEXT)
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .padding(.bottom, MARGIN_LARGE)
                .fontWeight(.semibold)
        }
    }
}

// Movie Seats Grid Section
struct MovieSeatsView: View {
    // let SEAT_COLUMNS_COUNT = 18
    //    let SEAT_SPACING = 7.0
    var columns = getGridItems(numberOfColumns: SEAT_COLUMNS_COUNT, spacing: SEAT_SPACING)
    //    var columns = getGridItems(numberOfColumns: SEAT_COLUMNS_COUNT)
    var seatArray: [CinemaSeatVO]?
    @Binding var seatId: [String]
    @Binding var seatName: [String]
    @Binding var seatPrice: Int
    @Binding var seatItemPrice: Int
    
    var onChooseSeat: ((String) -> Void)?
    
    var body: some View{
        LazyVGrid(columns: columns, spacing: MARGIN_MEDIUM_2) {
            // seats ?? [], id: \.seatName
            ForEach(seatArray ?? [], id: \.uniqueId) { seat in
                MovieSeatItemView(seat: seat)
                    .onTapGesture {
                        if (seat.isAvailable() && !seat.isSelected && !self.seatId.contains(seat.uniqueId)) {
                            
                            print("Seat Name===> \(seat.seatName ?? "")")
                            
                            self.seatPrice += seat.price ?? 0
                            self.seatId.append(seat.uniqueId)
                            self.seatName.append(seat.seatName ?? "")
                            
                            print("seat id array ==>", self.seatId)
                            
                            guard let onChooseSeat = self.onChooseSeat else { return }
                            onChooseSeat(seat.uniqueId)
                        } else {
                            print("Seat isn't available!")
                        }
                    }
                    .onAppear(){
                        self.seatItemPrice = seat.price ?? 0
                    }
            }
            
        }
    }
}

// Movie Seat
struct MovieSeatItemView: View {
    
    var seat: CinemaSeatVO? = nil
    
    var body: some View {
        if seat?.isAvailable() ?? false{
            if (seat?.isSelected ?? false) {
                Image(CHAIR_GREEN)
                    .resizable()
                    .frame(width: MOVIE_SEAT_SIZE, height: MOVIE_SEAT_SIZE)
                    .clipped()
            } else {
                Image(CHAIR_WHITE)
                    .resizable()
                    .frame(width: MOVIE_SEAT_SIZE, height: MOVIE_SEAT_SIZE)
                    .clipped()
            }
            
        } else if seat?.isTaken() ?? false{
            Image(CHAIR_GRAY)
                .resizable()
                .frame(width: MOVIE_SEAT_SIZE, height: MOVIE_SEAT_SIZE)
                .clipped()
        } else if seat?.isText() ?? false{
            Text(seat?.symbol ?? "")
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
                .frame(width: MOVIE_SEAT_SIZE, height: MOVIE_SEAT_SIZE)
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .fontWeight(.semibold)
        } else { // space
            Color.clear
                .frame(width: MOVIE_SEAT_SIZE, height: MOVIE_SEAT_SIZE)
        }
    }
}
