//
//  TicketCancelationPolicyView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/8.
//

import SwiftUI

struct TicketCancelationPolicyView: View {
    
    @Binding var showDialog: Bool
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            if showDialog {
                // Background color
                Color(BG_COLOR)
                    .opacity(0.7)
                    .ignoresSafeArea()
                    .onTapGesture {
                        self.showDialog = false
                    }
                
                TicketPolicyView(showDialog: $showDialog)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .animation(.easeInOut, value: 1)
        
    }
}

struct TicketCancelationPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        TicketCancelationPolicyView(showDialog: .constant(false))
    }
}

struct TicketPolicyView: View {
    
    @Binding var showDialog: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(TICKET_CANCELING_POLICY)
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, MARGIN_MEDIUM_4)
            
            HStack(spacing: MARGIN_MEDIUM){
                Image(FOOD_AND_BEVERAGE_IMG)
                    .resizable()
                    .frame(width: MARGIN_XLARGE - MARGIN_SMALL, height: MARGIN_LARGE)
                
                Text(REFUND_ON_FB_LABEL)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.top, MARGIN_LARGE)
            
            HStack(spacing: MARGIN_MEDIUM){
                Image(systemName: IC_TAB_THREE)
                    .resizable()
                    .frame(width: MARGIN_LARGE - 2, height: MARGIN_LARGE)
                    .foregroundColor(.white)
                
                Text(REFUND_ON_TICKET_LABEL)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }
            .padding(.top, MARGIN_LARGE)
            
            VStack(alignment: .leading, spacing: MARGIN_MEDIUM_4) {
                
                Text(REFUND_INFO_ONE)
                
                Text(REFUND_INFO_TWO)
            }
            .font(.system(size: MARGIN_HALF_LARGE))
            .foregroundColor(Color(SUB_TEXT_COLOR))
            .padding(.top, MARGIN_LARGE)
            .padding(.leading, OTP_PIN_SIZE)
            
            VStack(alignment: .leading, spacing: MARGIN_MEDIUM_3) {
                Text(REFUND_RULE_NO_ONE)
                
                Text(REFUND_RULE_NO_TWO)
                
            }
            .font(.system(size: MARGIN_HALF_LARGE))
            .foregroundColor(.white)
            .padding(.top, MARGIN_XLARGE + MARGIN_MEDIUM)
            
            Button(action: {
                showDialog = false
            }, label: {
                Text(CLOSE_BUTTON_LABEL)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: MARGIN_MEDIUM_1, leading: MARGIN_XLARGE, bottom: MARGIN_MEDIUM_1, trailing: MARGIN_XLARGE))
            })
            .frame(width: TICKET_CANCELATION_WIDTH - MARGIN_XLARGE)
            .background(Color(PRIMARY_COLOR))
            .cornerRadius(MARGIN_MEDIUM)
            .padding([.top, .bottom], MARGIN_LARGE)
        }
        .padding([.leading, .trailing], MARGIN_MEDIUM_2)
        .background(Color(BG_COLOR))
        .frame(width: TICKET_CANCELATION_WIDTH, height: TICKET_CANCELATION_HEIGHT)
        .cornerRadius(MARGIN_MEDIUM)
        .overlay(RoundedRectangle(cornerRadius: MARGIN_MEDIUM)
            .stroke(Color(PRIMARY_COLOR),lineWidth: 2))
    }
}
