//
//  DateItemSubView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/12.
//

import SwiftUI

struct DateItemSubView: View {
    
    var date: Date?
    var isSelected: Bool?
    @Binding var selectDate: Date
    
    @State var day : String? = nil
    @State var month: String? = nil
    @State var dayOfMonth: Int? = nil
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
            DateBackgroundView(isSelected: isSelected)
            
            VStack(spacing: 0.0) {
                Text(day ?? "")
                    .font(.system(size: MARGIN_HALF_LARGE))
                    .fontWeight(.medium)
                   
                Text(month ?? "")
                    .font(.system(size: MARGIN_HALF_LARGE))
                    .fontWeight(.medium)
                    .padding(.top,MARGIN_MEDIUM - 1)
                
                Text(String(dayOfMonth ?? 0))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
                    .padding(.top, MARGIN_SMALL + 1)
                
            }
            .foregroundColor(Color(.black))
            .padding(.top, MARGIN_MEDIUM_4)
            
        })
        .frame(width: MARGIN_XBIG + MARGIN_SMALL, height: MARGIN_XBIG + MARGIN_MEDIUM_2 - 1)
        .onAppear(){
            let first = Date.now
            let second = Date.now.addingTimeInterval(86400)
            if (Calendar.current.isDate(first, inSameDayAs: date ?? Date())) {
                day = "Today"
            } else if (Calendar.current.isDate(date ?? Date(), equalTo: second, toGranularity: .day)) {
                day = "Tomorrow"
            } else {
                day = changeDateFormat(date: date ?? Date())
            }
            month = getMonthFromDate(date: date ?? Date())
            dayOfMonth = getDayOfMonthFromDate(date: date ?? Date())
        }
        .onTapGesture {
            print(date ?? Date())
            self.selectDate = date ?? Date()
        }
    }
    
    // Thursday, July 27, 2023 at 1:10:05 PM Myanmar Time
    // Jul 27, 2023 at 1:11:28 PM
    func changeDateFormat(date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = DateFormatter.Style.full
        df.timeStyle = DateFormatter.Style.medium
        
        let result = df.string(from: date)
        // String(format: "%.2f", Double(movie?.rating ?? 0.0))
        let dayString = result.split(separator: ",")[0]
        let day = String(dayString.prefix(3))
        
        return day
    }
    
    func getMonthFromDate(date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = DateFormatter.Style.full
        df.timeStyle = DateFormatter.Style.medium
        
        let result = df.string(from: date)
        let monthString = (result.split(separator: ",")[1]).replacingOccurrences(of: " ", with: "")
        let month = String(monthString.prefix(3))
        return month
    }
    
    func getDayOfMonthFromDate(date: Date) -> Int {
        let df = DateFormatter()
        df.dateStyle = DateFormatter.Style.full
        df.timeStyle = DateFormatter.Style.medium
        
        let result = df.string(from: date)
        let monthString = result.split(separator: ",")[1]
        var dayOfMonth = Int(monthString.suffix(2)) ?? 0
        if (dayOfMonth < 10) {
            dayOfMonth = Int(monthString.suffix(1)) ?? 0
        }
        return dayOfMonth
    }
}

struct DateItemSubView_Previews: PreviewProvider {
    static var previews: some View {
        DateItemSubView(date: Date(), isSelected: false, selectDate: .constant(Date()))
    }
}
