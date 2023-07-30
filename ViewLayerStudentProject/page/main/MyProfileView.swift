//
//  MyProfileView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI

struct MyProfileView: View {
    
    let profileData: [ProfileSettingVO] = profileSettingData
    
    var body: some View {
        ZStack{
            // Background color
            Color(BG_COLOR)
            
            VStack(alignment: .leading, spacing: 0.0) {
                ProfileTopView()
                    .padding(.top, MARGIN_XBIG)
                
                PaymentSettingView(profileData: profileData)
                
                Spacer()
            }
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}

struct ProfileTopView: View {
    var body: some View {
        ZStack {
            Image(PROFILE_BG_IMG)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: PROFILE_IMAGE_HEIGHT)
            
            VStack {
                Image(systemName: IC_PROFILE_CIRCLE)
                    .resizable()
                    .frame(width: PROFILE_ICON_SIZE, height: PROFILE_ICON_SIZE)
                    .foregroundColor(Color(PRIMARY_COLOR))
                
                Text(LOGIN_OR_SIGN_UP)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .foregroundColor(Color(PRIMARY_COLOR))
                    .padding(MARGIN_MEDIUM)
                    .frame(width: DONE_BUTTON_WIDTH)
                    .overlay(RoundedRectangle(cornerRadius: MARGIN_MEDIUM).stroke(Color(PRIMARY_COLOR),lineWidth: 1))
                    .padding(.top, MARGIN_MEDIUM_1)
            }
            
        }
    }
}

struct PaymentSettingView: View {
    
    var profileData: [ProfileSettingVO]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            ForEach(profileData) { datum in
                HStack{
                    Image(systemName: datum.image)
                        .foregroundColor(.white)
                    
                    Text(datum.profileText)
                        .font(.system(size: MARGIN_MEDIUM_3))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: IC_CHEV_RIGHT)
                        .foregroundColor(Color(SUB_TEXT_COLOR))
                        .fontWeight(.bold)
                }
                .padding(MARGIN_MEDIUM_4)
                
                Divider()
                    .background(Color(SUB_TEXT_COLOR)).opacity(0.7)
                    .padding([.leading, .trailing],MARGIN_MEDIUM_2)
            }
        }
    }
}
