//
//  TimeSlotScreenView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/12.
//

import SwiftUI

struct TimeSlotScreenView: View {
   
    @Environment(\.dismiss) var dismiss
    let mModel: MovieModel = MovieModelImpl.shared
    let uModel: UserModel = UserModelImpl.shared
    @State var cinemaList: [CinemaVO]? = nil
    @State var date: Date = Date.now
    let now = Date.now
    @State var selectDate = Date.now
    
    var movieId: Int?
    var cityName: String?
    var movieName: String?
    var posterImageLink: String?
    
    @State var isTimeSlotClick: Bool = false
    @State var dateArray: [DateVO]? = dummyDateData
    @State var slotID: Int = 0
    @State var timeSlotCount : Int = 0
    
    var body: some View {
        ZStack{
            Color(BG_COLOR)
            VStack(spacing: 0){
                // AppBar
                AppBar(cityName: cityName ?? ""){
                    dismiss()
                }

                // DateList
                DateListView(dateList: self.dateArray, selectDate: $selectDate){ dateSelected in
                    dateArray = dateArray?.map({ dateVO in
                        if (Calendar.current.isDate(dateVO.date ?? Date(), inSameDayAs: dateSelected)) {
                            return DateVO(date: dateVO.date, isSelected: true)
                        } else {
                            return DateVO(date: dateVO.date, isSelected: false)
                        }
                    })
                    print("Date Selected \(dateSelected)")
                    self.requestData(date1: dateSelected)
                }
                .padding(.top, MARGIN_XLARGE)

                    
                // Viewingtype Section
                ViewingTypeSectionView()
                    .padding(.top, MARGIN_LARGE)
                
                // TimeSlot Color section
                TimeSlotColorsView()
                    .padding(.top, MARGIN_LARGE)
                
               
                    // TimeSlots and hint section
                CinemaListView(cinemaList: cinemaList, slotID: $slotID, timeSlotCount: timeSlotCount)
            }
            .padding(.top, MARGIN_XBIG - MARGIN_MEDIUM)
//            .navigationDestination(for: Timeslot.self) { slot in
//                SeatingPlanPageView(userId: self.userId, date: self.selectDate, slotId: slot.cinemaDayTimeslotID)
//            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $isTimeSlotClick, content: {
            SeatingPlanPageView(date: self.selectDate, slotId: self.slotID, movieId: self.movieId, movieTitle: self.movieName, posterImageLink: self.posterImageLink)
        })
        .onAppear(){
            
           requestData(date1: date)
        }
//        .onChange(of: self.selectDate) { newValue in
//            print("Selected Date ===> \(newValue)")
//            print("slot id ==> \(self.slotID)")
//
//        }
        .onChange(of: self.slotID) { newValue in
            print("Slot \(newValue)")
            self.isTimeSlotClick = true
        }
       
    }

    // get Data from Data layer
    func requestData(date1: Date) {
        
        let computedDate = self.computeDatetoCorrectDate(date: date1)
        print("Computed Date \(computedDate)")
        
        mModel.getCinemaAndTimeSlotRecord(date: computedDate) { list in
            
            self.cinemaList = nil

            let result = list.map({ cinema in
                cinema.timeSlots?.map({ timeslot in
                    timeslot.cinemaDayTimeslotID
                })
            })
            print(result)
            self.timeSlotCount += 1
            self.cinemaList = list
           
        } onFailure: { error in
            debugPrint(error)
        }

    }
    // Computed date data
    func computeDatetoCorrectDate(date: Date) -> String{
        let df = DateFormatter()
        df.dateStyle = DateFormatter.Style.short
        df.timeStyle = DateFormatter.Style.short
        print(date)
        
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let year = components.year ?? 0
        let month = components.month ?? 0
        
        let day = components.day ?? 0
        let monthString = (month<10 ? "0\(month)" : "\(month)")
        let dayString = (day<10 ? "0\(day)" : "\(day)")
        let computedDate = "\(year)-\(monthString)-\(dayString)"
    
        print(computedDate)
        return computedDate
    }
}

struct TimeSlotScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSlotScreenView()
    }
}

struct AppBar: View {
    
    var cityName: String
    var onTapBack: () -> Void = {}
    
    var body: some View {
        HStack{
            Image(systemName: IC_CHEV_LEFT)
                .resizable()
                .frame(width: MARGIN_HALF_LARGE - 1, height: MARGIN_LARGE - 2)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding([.leading, .trailing], MARGIN_LARGE)
                .onTapGesture {
                    // TODO: Navigate Back
                    onTapBack()
                }
            Spacer()
            
            Image(systemName: IC_LOCATION)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2, height: MARGIN_MEDIUM_2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("\(cityName)")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding([.trailing, .leading], MARGIN_LARGE)
            
            Image(FILTER_IMAGE_NORMAL)
                .resizable()
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                .fontWeight(.bold)
                .padding(.trailing, MARGIN_LARGE)
        }
    }
}

struct DateListView: View {
    
    var dateList: [DateVO]?
    @Binding var selectDate: Date
    var onChooseDate: ((Date) -> Void)?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
                ForEach(dateList ?? [], id: \.date) { dateValue in
                    DateItemSubView(date: dateValue.date, isSelected: dateValue.isSelected, selectDate: $selectDate)
                }
              
            }
            .padding(.leading, MARGIN_SMALL)
            
        }
        .onChange(of: self.selectDate) { newValue in
            guard let onChooseDate = self.onChooseDate else { return }
            onChooseDate(newValue)
        }
       
    }
 
}

struct ViewingTypeItemView: View {
    
    var viewType: String
    
    var body: some View {
        Text(viewType)
            .font(.system(size: MARGIN_MEDIUM_2))
            .foregroundColor(.white)
            .fontWeight(.medium)
            .padding(EdgeInsets(top: MARGIN_MEDIUM - 3, leading: MARGIN_MEDIUM_2, bottom: MARGIN_SMALL + 1, trailing: MARGIN_MEDIUM_2))
            .background(Color(SECTION_BG_COLOR))
            .cornerRadius(MARGIN_SMALL + 1)
            .overlay(RoundedRectangle(cornerRadius: MARGIN_SMALL + 1).stroke(.white, lineWidth: 1))
            .padding([.top, .bottom], MARGIN_SMALL)
    }
}

struct ViewingTypeSectionView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: MARGIN_MEDIUM_3){
                ViewingTypeItemView(viewType: "2D")
                ViewingTypeItemView(viewType: "3D")
                ViewingTypeItemView(viewType: "3D IMAX")
                ViewingTypeItemView(viewType: "3D DBOX")
            }
            .padding([.leading, .trailing], MARGIN_MEDIUM_4)
        }
    }
}
struct TimeSlotColorsView: View {
    var body: some View{
        ZStack {
            HStack(spacing: MARGIN_LARGE){
                TimeSlotColorItemView(color: GREEN_LIGHT_COLOR, text: "Available")
                TimeSlotColorItemView(color: ORANGE_COLOR, text: "Filling Fast")
                TimeSlotColorItemView(color: PINK_COLOR, text: "Almost Full")
            }
            .padding([.leading, .trailing], MARGIN_LARGE - 2)
        }
        .frame(width: UIScreen.main.bounds.width,height: MARGIN_XLARGE + MARGIN_SMALL)
        .background(Color(SECTION_ICON_COLOR))
    }
    
}
struct TimeSlotColorItemView: View {
    
    var color: String
    var text: String
    
    var body: some View{
        HStack(spacing: MARGIN_MEDIUM) {
            Circle()
                .frame(width: MARGIN_MEDIUM, height: MARGIN_MEDIUM)
                .foregroundColor(Color(color))
            
            Text(text)
                .foregroundColor(Color(color))
                .font(.system(size: MARGIN_MEDIUM_2))
        }
    }
}

struct CinemaListView: View {
    
    var cinemaList: [CinemaVO]?
    @Binding var slotID: Int
    var timeSlotCount: Int?
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(cinemaList ?? [], id: \.cinemaId) { Item in
                // Time slot item
                CinemaAndTimeSlotsItem(cinema: Item, count: cinemaList?.count, timeSlotCount: timeSlotCount,  slotID: $slotID)
                
            }
        }
    }
}
