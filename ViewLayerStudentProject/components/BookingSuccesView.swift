//
//  BookingSuccesView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/11.
//

import SwiftUI

struct BookingSuccesView: View {
    
    @State var isSuccessBooking = false
    
    var body: some View {
        ZStack(alignment: .center) {
            
            if !isSuccessBooking {
                // Background color
                Color(.black)
                    .opacity(0.8)
                    .ignoresSafeArea()
                    
                // success popup image
                Image(BOOKING_SUCCESS_IMG)
                    .resizable()
                    .frame(width: BOOKING_SUCCESS_WIDTH - MARGIN_LARGE, height: BOOKING_SUCCESS_HEIGHT)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .animation(.easeInOut, value: 1)
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(2.0)) {
                withAnimation {
                    self.isSuccessBooking = true
                }
            }
        }

    }
}

struct BookingSuccesView_Previews: PreviewProvider {
    static var previews: some View {
        BookingSuccesView()
    }
}
