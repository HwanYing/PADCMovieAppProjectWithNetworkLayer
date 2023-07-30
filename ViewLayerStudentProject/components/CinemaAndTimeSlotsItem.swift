//
//  CinemaAndTimeSlotsItem.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/12.
//

import SwiftUI

struct CinemaAndTimeSlotsItem: View {
    
    @State var timeSlotExpanding: Bool = false
//    var place: String
//    var placeId: Int = 1
    @State var isSeparatorShown: Bool = true
    var cinema: CinemaVO?
    var count: Int?
    @Binding var slotID: Int
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 0) {
                // Name, See Details
                HStack {
                    Text(cinema?.cinema ?? "")
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(SEE_DETAILS)
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .foregroundColor(Color(PRIMARY_COLOR))
                        .fontWeight(.bold)
                        .underline()
                        .onTapGesture {
                            timeSlotExpanding.toggle()
                        }
                }
                // Cinema Facility list
                CinemaFacilitiesListView(textColor: Color(FACILITY_TEXT_COLOR), primaryOrNot: false)
                    .padding(.top, MARGIN_MEDIUM_4)
                
                // Time Slots and Hint
                if timeSlotExpanding {
                        VStack(alignment: .leading, spacing: 0) {
                            
                            TimeSlotsView(data: cinema?.timeSlots, slotID: $slotID)
                           
                            // Longpress hint
                            LongPressHintView()
                        }
                        .padding(.top, MARGIN_LARGE)
                } else {
                    EmptyView()
                }
                
            }
            .padding(EdgeInsets(top: MARGIN_XLARGE - 2, leading: MARGIN_LARGE, bottom: MARGIN_XLARGE - 2, trailing: MARGIN_LARGE))
            .onTapGesture {
                withAnimation {
                    timeSlotExpanding.toggle()
                }
            }
            // Separator
            if isSeparatorShown{
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(SUB_TEXT_COLOR))
                    .padding(.bottom, MARGIN_SMALL / 2)
            } else {
                EmptyView()
            }
        }
        .background(Color(BG_COLOR))
        .onAppear(){
            print(cinema?.cinemaId ?? 0)
            print(count ?? 0)
            let countReceive = Int(count ?? 0)
            let id = Int(cinema?.cinemaId ?? 0)
            if (id > countReceive) {
                self.isSeparatorShown = false
            } else {
                self.isSeparatorShown = true
            }
        }
    }
}

struct CinemaAndTimeSlotsItem_Previews: PreviewProvider {
    static var previews: some View {
        CinemaAndTimeSlotsItem(slotID: .constant(0))
            .background(Color(BG_COLOR))
    }
}
// Facilities Item
struct FacilityItemView: View {
    
    var image: String
    var text: String
    var textColor: Color
    
    var body: some View {
        HStack(spacing: MARGIN_SMALL){
            Image(image)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2, height: MARGIN_MEDIUM_2)
            
            Text(text)
                .font(.system(size: MARGIN_HALF_LARGE))
                .fontWeight(.medium)
                .foregroundColor(textColor)
        }
    }
}
// Cinema Facility list
struct CinemaFacilitiesListView: View {
    
    var textColor: Color
    var primaryOrNot: Bool
    
    var body: some View {
        HStack(spacing: MARGIN_MEDIUM_2){
            
            FacilityItemView(image: primaryOrNot ? PARKING_IMG_GREEN : PARKING_IMG_GRAY, text: "Parking", textColor: textColor)
            FacilityItemView(image: primaryOrNot ? ONLINE_FOOD_IMG_GREEN : ONLINE_FOOD_IMG_GRAY, text: "Online Food", textColor: textColor)
            FacilityItemView(image: primaryOrNot ? WHEEL_CHAIR_GREEN : WHEEL_CHAIR_IMG, text: "Wheel Chair", textColor: textColor)
        }
    }
}
// Time Slot Item
struct TimeSlotItemView: View {
    
    var timeSlot: Timeslot?
    @State var bgColor : String? = nil
    @State var borderColor: String? = nil
    @State var status : Int = 0
    // almost full ==> TIME_COLOR_PINK, borderColor: PINK_COLOR
    // filling_fast ===> bgColor: TIME_COLOR_ORANGE, borderColor: NEW_ORANGE_COLOR
    // available ===> bgColor: TIME_COLOR_GREEN, borderColor: GREEN_LIGHT_COLOR
    
    var body: some View {
        ZStack{
//            Color(bgColor ?? "")
            
            VStack(alignment: .center, spacing: MARGIN_SMALL) {
                Text(timeSlot?.startTime ?? "")
                    .font(.system(size: MARGIN_HALF_LARGE))
                
                Text("2D")
                    .font(.system(size: MARGIN_CARD_MEDIUM_2))
                
                Text("Screen \(status)")
                    .font(.system(size: MARGIN_CARD_MEDIUM_2))
                    .onAppear(){
                        self.status = Int(timeSlot?.status ?? 0)
                    }
                if borderColor != GREEN_LIGHT_COLOR {
                    
                    Text("21 Available")
                        .font(.system(size: MARGIN_CARD_MEDIUM_2))
                }
               
            }
            .foregroundColor(Color.white)
            .fontWeight(.medium)
            
        }
        .frame(width: TIME_SLOT_WIDTH, height: TIME_SLOT_HEIGHT)
        .background(Color(bgColor ?? ""))
        .overlay(RoundedRectangle(cornerRadius: MARGIN_SMALL).stroke(Color(borderColor ?? ""), lineWidth: 1))
        .onAppear(){
            if (timeSlot?.status == 1) {
                bgColor = TIME_COLOR_PINK
                borderColor = PINK_COLOR
            } else if (timeSlot?.status == 2) {
                bgColor = TIME_COLOR_ORANGE
                borderColor = NEW_ORANGE_COLOR
            } else {
                bgColor = TIME_COLOR_GREEN
                borderColor = GREEN_LIGHT_COLOR
            }
        }
    }
}
// Long Press Hint
struct LongPressHintView: View {
    var body: some View {
        HStack(spacing: MARGIN_SMALL) {
            Image(systemName: IC_INFO_CIRCLE_FILL)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2, height: MARGIN_MEDIUM_2)
                .foregroundColor(Color(FACILITY_TEXT_COLOR))
            
            
            Text("Long press on show timing to see seats class!")
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(Color(FACILITY_TEXT_COLOR))
                .fontWeight(.bold)
        }
        .padding(.top, MARGIN_LARGE)
    }
}
// Time Slots
struct TimeSlotsView: View {

    let columns = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    var data : [Timeslot]?
    @Binding var slotID: Int
// almost full ==> TIME_COLOR_PINK, borderColor: PINK_COLOR
    // filling_fast ===> bgColor: TIME_COLOR_ORANGE, borderColor: NEW_ORANGE_COLOR
    // available ===> bgColor: TIME_COLOR_GREEN, borderColor: GREEN_LIGHT_COLOR
    
    var body: some View {
        
        if (data?.isEmpty ?? true) {
            EmptyView()
        } else {
            LazyVGrid(columns: columns) {
                ForEach(data ?? [], id: \.cinemaDayTimeslotID) { timeslot in
                    // time slot item
//                    NavigationLink(value: timeslot) {
                        TimeSlotItemView(timeSlot: timeslot)
//                    }
                    .buttonStyle(.plain)
                    .onTapGesture {
                        self.slotID = timeslot.cinemaDayTimeslotID ?? 0
                        print("Slot id ----> \(self.slotID)")
                    }
                }
            }

        }
    }
}
