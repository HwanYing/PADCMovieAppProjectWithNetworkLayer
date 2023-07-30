//
//  ContentView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/1.
//

import SwiftUI

struct ContentView: View {
    
    let uModel: UserModel = UserModelImpl.shared
    
    @Binding var isActive: Bool
    @State var phNumber = ""
    @State var isSelecting = false
    @State var selectionTitle = "95"
    @State var confirmOTP = false
    @State var isEnteringPh = false
    
    var body: some View {
//        NavigationStack {
            ZStack {
                // background color
                Color(BG_COLOR)
                if isActive {
                    ScrollView {
                        VStack(spacing: 0.0) {
                            
                            // App Icon, Notice Verify Text
                            AppIconAndNoticeView()
                            
                            
                            VStack(alignment: .leading ,spacing: 0.0){
                                // Mobile Text Section
                                MobileFieldAndCodeView(selectionTitle: $selectionTitle, phNumber: $phNumber)
                                
                                // Verify Button, google button and terms
                                FooterAndButtonView(phone: phNumber, isShowing: $isEnteringPh){
                                    fetchOTPCode()
                                }
                                
                            }
                            .padding([.leading, .trailing], MARGIN_MEDIUM_2)
                        }
                        .fullScreenCover(isPresented: $confirmOTP) {
                            ConfirmOTPView(phNumber: phNumber, confirmOTP: $confirmOTP)
                        }
//                        .navigationDestination(isPresented: $confirmOTP) {
//                            ConfirmOTPView(phNumber: phNumber, confirmOTP: $confirmOTP)
//                        }
                    }
                    .padding(.top, TOP_PADDING_1)
                    .toast(message: "Please Enter Phone Number before clicking VERIFY button!",
                           isShowing: $isEnteringPh,
                           duration: Toast.short)
                }
                
            }
            .edgesIgnoringSafeArea(.vertical)
//        }
    }
    func fetchOTPCode() {
        // Get OTP
        uModel.getOTPCode(phoneNo: phNumber) { success in
            debugPrint(success)
            self.confirmOTP = true
        } onFailure: { error in
            debugPrint(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isActive: .constant(false))
    }
}

struct CustomTextField : View {
    
    @Binding var value: String
    var placeHolder: String
    var bColor: Color
    var bottomColor: Color
    
    var body: some View {
        ZStack(alignment: .leading){
            if value.isEmpty {
                Text(placeHolder)
                    .foregroundColor(bColor)
                    .font(.system(size:MARGIN_MEDIUM_2))
                    .padding(.leading, MARGIN_CARD_MEDIUM_2)
            }
            TextField("", text: $value)
                .padding(.leading, MARGIN_CARD_MEDIUM_2)
                .font(.system(size: MARGIN_MEDIUM_2))
                .frame(height: TEXT_FIELD_HEIGHT)
                .foregroundColor(.white)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.phonePad)
                
        }
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).padding(.leading, MARGIN_CARD_MEDIUM_2).foregroundColor(bottomColor), alignment: .bottom)

    }
}
//struct DropdownMenuItemView: View {
//
//    @Binding var isSelecting : Bool
//    @Binding var selectionTitle: String
//    @Binding var selectionId: Int
//
//    let item: CountryCodeItem
//
//    var body: some View {
//        Button(action: {
//
//            isSelecting = false
//            selectionTitle = item.title
//            selectionId = item.id
//            item.onSelect()
//            if isSelecting {
//                ZStack{
//                    VStack(spacing: 5){
//                        DropdownMenuItemView(isSelecting: $isSelecting, selectionTitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 1, title: "95", onSelect: {}))
//                        Divider()
//                            .background(Color(SUB_TEXT_COLOR))
//                        DropdownMenuItemView(isSelecting: $isSelecting, selectionTitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 2, title: "85", onSelect: {}))
//
//                        Divider()
//                            .background(Color(SUB_TEXT_COLOR))
//
//                        DropdownMenuItemView(isSelecting: $isSelecting, selectionTitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 3, title: "75", onSelect: {}))
//
//                    }
//                }
//                .frame(width: 80)
//            }
//        }, label: {
//            HStack {
//                Text("+\(item.title)")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//            }
//        })
//    }
//}

struct MobileFieldAndCodeView: View {
    
    @Binding var selectionTitle: String
    @Binding var phNumber: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(COUNTRY_CODE)
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .padding(.top, MARGIN_XXLARGE)
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
            
            // Mobile Number Section, textfield
            HStack {
                HStack{
                    Text("+\(selectionTitle)")
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: IC_CHEV_DOWN)
                        .foregroundColor(Color(SUB_TEXT_COLOR))
                        .fontWeight(.bold)
                        .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_MEDIUM)
                }
                .foregroundColor(.white)
                .frame(width: MARGIN_XBIG, height: TEXT_FIELD_HEIGHT)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.white), alignment: .bottom)
                //                            .onTapGesture {
                //                                isSelecting.toggle()
                //                            }
                
                CustomTextField(value: $phNumber, placeHolder: MOBILE_NO_HOLDER, bColor: Color(SUB_TEXT_COLOR), bottomColor: Color(.white))
            }
            
        }
    }
}

struct FooterAndButtonView: View {
    
    var phone: String
    @Binding var isShowing: Bool
    var onTapVerifyBtn: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Button(action: {
                if (!phone.isEmpty){
                    onTapVerifyBtn()
                } else {
                    self.isShowing = true
                }
            }, label: {
                Text(VERIFY_TEXT)
                    .padding()
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - MARGIN_XLARGE)
            })
            .background(Color(PRIMARY_COLOR))
            .cornerRadius(MARGIN_MEDIUM)
            .padding(.top, TOP_PADDING_MEDIUM)
            
            HStack {
                
                VStack {
                    Divider()
                        .frame(height: 1)
                        .background(Color(SUB_TEXT_COLOR))
                }
                Text(OR_VALUE)
                    .foregroundColor(.white)
                VStack {
                    Divider()
                        .frame(height: 1)
                        .background(Color(SUB_TEXT_COLOR))
                }
            }
            .padding(.top, MARGIN_BTN_SPACING)
            
            Button(action: {
                
            }, label: {
                HStack {
                    Image(GOOGLE_IMAGE)
                        .resizable()
                        .frame(width: GG_Size, height: GG_Size)
                    
                    Text(GOOGLE_BTN_LABEL)
                        .padding([.top, .bottom], MARGIN_MEDIUM_2)
                        .foregroundColor(.black)
                        .padding(.leading, MARGIN_MEDIUM_1)
                }
                .frame(width: UIScreen.main.bounds.width - MARGIN_XLARGE)
            })
            .background(.white)
            .cornerRadius(MARGIN_MEDIUM)
            .padding(.top, MARGIN_BTN_SPACING)
            
            // Privacy Terms
            Text(TERMS_LABEL)
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
                .padding(.top, FOOTER_PADDING)
                .padding([.leading, .trailing], MARGIN_SMALL)
        }
    }
}

struct AppIconAndNoticeView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            // Image
            Image(APP_LOGO)
                .resizable()
                .frame(width: IMAGE_WIDTH, height: IMAGE_HEIGHT)
            
            // verify text
            Text(VERIFY_TEXT)
                .font(.system(size: TEXT_SMALL_HEADING))
                .foregroundColor(.white)
                .padding(.top, MARGIN_XXLARGE)
            
            Text(NOTICE_TEXT)
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .frame(width: TEXT_VERIFY_WIDTH, height: TEXT_VERIFY_HEIGHT)
                .padding(.top, MARGIN_MEDIUM)
        }
    }
}
