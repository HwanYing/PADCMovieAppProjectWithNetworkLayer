//
//  ConfirmOTPView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/4.
//

import SwiftUI
import Combine

enum FocusPin {
    case pinOne
    case pinTwo
    case pinThree
    case pinFour
    case pinFive
    case pinSix
}
struct ConfirmOTPView: View {
    
    let uModel: UserModel = UserModelImpl.shared

    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSix: String = ""

    var phNumber: String?
    @Binding var confirmOTP: Bool
    @State var selectRegion = false
    @State var userID: Int?

    var body: some View {
        ZStack {
            Color(BG_COLOR)
            
            VStack(spacing: 0.0) {
                
                // App logo, notice text
                AppLogoSectionView(backToFrontView: $confirmOTP)
                
                
                // enter OTP section
                OTPCodeFieldSectionView(pinOne: $pinOne, pinTwo: $pinTwo, pinThree: $pinThree, pinFour: $pinFour, pinFive: $pinFive, pinSix: $pinSix)
                
                // OTP Text Field Section View
                OTPReceiveStateSection()
                
                // Button, Terms Label
                FooterSectionView(){
                    let otp = "\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)\(pinSix)"
                    confirmOTPCode(phNo: phNumber ?? "", otpString: otp)
                }
               
                
            }
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
//        .navigationDestination(isPresented: $selectRegion) {
//            PickRegionView(userID: userID, selectRegion: $selectRegion)
//        }
        .fullScreenCover(isPresented: $selectRegion) {
            PickRegionView(selectRegion: $selectRegion)
        }
    }
    func confirmOTPCode(phNo: String, otpString: String) {
        uModel.checkOTPCode(phone: phNo, otp: otpString) { user in
            debugPrint(user)
            debugPrint("User ID===> ", user.data?.id ?? 0)
            self.selectRegion = true

        } onFailure: { error in
            debugPrint(error)
        }

    }
}

struct ConfirmOTPView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmOTPView(phNumber: "", confirmOTP: .constant(false))
    }
}

struct OTPCodeFieldSectionView: View {
    
    @FocusState private var pinFocusState : FocusPin?

    @Binding var pinOne: String
    @Binding var pinTwo: String
    @Binding var pinThree: String
    @Binding var pinFour: String
    @Binding var pinFive: String
    @Binding var pinSix: String

    var body: some View {
        VStack (spacing: 0.0) {
            
            HStack {
                Text(ENTER_OTP_TEXT)
                    .foregroundColor(Color(LIGHT_LABEL_COLOR))
                Spacer()
            }
            .padding([.leading, .trailing], MARGIN_LARGE)
            
            HStack(spacing: MARGIN_MEDIUM_2) {
                //                ForEach(0...5, id: \.self) { i in
                TextField("", text: $pinOne)
                    .modifier(OtpModifer(pin: $pinOne))
                    .onChange(of: pinOne, perform: { newValue in
                        if (newValue.count == 1) {
                            pinFocusState = .pinTwo
                        }
                    })
                    .focused($pinFocusState, equals: .pinOne)
//                    .padding(.leading, MARGIN_MEDIUM_3)
//                    .frame(width: OTP_PIN_SIZE, height: OTP_PIN_SIZE)
//                    .background(Color.white)
//                    .foregroundColor(Color(BG_COLOR))
//                    .cornerRadius(MARGIN_MEDIUM)
                    
                
                TextField("", text:  $pinTwo)
                    .modifier(OtpModifer(pin:$pinTwo))
                    .onChange(of:pinTwo){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinThree
                        } else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinOne
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinTwo)
                
                
                TextField("", text:$pinThree)
                    .modifier(OtpModifer(pin:$pinThree))
                    .onChange(of:pinThree){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinFour
                        } else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinTwo
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinThree)
                
                
                TextField("", text:$pinFour)
                    .modifier(OtpModifer(pin:$pinFour))
                    .onChange(of: pinFour, perform: { newValue in
                        if (newValue.count == 1) {
                            pinFocusState = .pinFive
                        } else if (newValue.count == 0) {
                            pinFocusState = .pinThree
                        }
                    })
                    .focused($pinFocusState, equals: .pinFour)
                
                
                TextField("", text:$pinFive)
                    .modifier(OtpModifer(pin:$pinFive))
                    .onChange(of: pinFive, perform: { newValue in
                        if (newValue.count == 1) {
                            pinFocusState = .pinSix
                        } else if (newValue.count == 0) {
                            pinFocusState = .pinFour
                        }
                    })
                    .focused($pinFocusState, equals: .pinFive)
                
                TextField("", text:$pinSix)
                    .modifier(OtpModifer(pin:$pinSix))
                    .onChange(of: pinSix, perform: { newValue in
                        if (newValue.count == 0) {
                            pinFocusState = .pinFive
                        }
                    })
                    .focused($pinFocusState, equals: .pinSix)
//                    .padding(.leading, MARGIN_MEDIUM_3)
//                    .frame(width: OTP_PIN_SIZE, height: OTP_PIN_SIZE)
//                    .background(Color.white)
//                    .foregroundColor(Color(BG_COLOR))
//                    .cornerRadius(MARGIN_MEDIUM)
                
//                TextField("", text: $number3)
//                    .padding(.leading, MARGIN_MEDIUM_3)
//                    .frame(width: OTP_PIN_SIZE, height: OTP_PIN_SIZE)
//                    .background(Color.white)
//                    .foregroundColor(Color(BG_COLOR))
//                    .cornerRadius(MARGIN_MEDIUM)
//
//                TextField("", text: $number4)
//                    .padding(.leading, MARGIN_MEDIUM_3)
//                    .frame(width: OTP_PIN_SIZE, height: OTP_PIN_SIZE)
//                    .background(Color.white)
//                    .foregroundColor(Color(BG_COLOR))
//                    .cornerRadius(MARGIN_MEDIUM)
//
//                TextField("", text: $number5)
//                    .padding(.leading, MARGIN_MEDIUM_3)
//                    .frame(width: OTP_PIN_SIZE, height: OTP_PIN_SIZE)
//                    .background(Color.white)
//                    .foregroundColor(Color(BG_COLOR))
//                    .cornerRadius(MARGIN_MEDIUM)
//
//                TextField("", text: $number6)
//                    .padding(.leading, MARGIN_MEDIUM_3)
//                    .frame(width: OTP_PIN_SIZE, height: OTP_PIN_SIZE)
//                    .background(Color.white)
//                    .foregroundColor(Color(BG_COLOR))
//                    .cornerRadius(MARGIN_MEDIUM)
                //                }
            }
            .padding(.top, MARGIN_MEDIUM)
            
            
        }
        .padding(.top, TEXT_XBIG - MARGIN_SMALL)
    }
}

struct OTPReceiveStateSection: View {
    var body: some View {
        HStack {
            Text(OTP_STATE_LABEL_2)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_2))
            
            Text(RESEND_CODE_LABEL)
                .foregroundColor(Color(PRIMARY_COLOR))
                .font(.system(size: MARGIN_MEDIUM_2))
        }
        .padding(.top, MARGIN_SXLARGE)
    }
}

struct FooterSectionView: View {
    
    var onTapConfirmBtn: () -> Void = {}

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            Button(action: {
                // Navigate to Select Region Page
                onTapConfirmBtn()
            }) {
                Text(CONFIRM_OTP_LABEL)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - MARGIN_XXLARGE)
            }
            .background(Color(PRIMARY_COLOR))
            .cornerRadius(MARGIN_MEDIUM)
            .padding(.top, MARGIN_SXLARGE)
            
            Text(TERMS_LABEL)
                .foregroundColor(Color(BOTTOM_TEXT_COLOR))
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
                .fontWeight(.bold)
                .padding(.top, TOP_PADDING_1 + MARGIN_MEDIUM)
        }
    }
}

struct AppLogoSectionView: View {
    
    @Binding var backToFrontView: Bool
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                // Back Button
                Image(systemName: IC_CHEV_LEFT)
                    .resizable()
                    .frame(width: MARGIN_MEDIUM_2, height: MARGIN_LARGE)
                    .fontWeight(.bold)
                    .foregroundColor(Color(SECTION_BG_COLOR))
                    .onTapGesture {
                        backToFrontView = false
                    }
                Spacer()
            }
            .padding(.leading, MARGIN_LARGE)
            
            // Image
            Image(APP_LOGO)
                .resizable()
                .frame(width: IMAGE_WIDTH, height: IMAGE_HEIGHT)
            
            // State text
            Text(OTP_STATE_LABEL_1)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_LARGE))
                .padding(.top, FOOTER_PADDING)
            Text(NO_OF_DIGIT_NOTICE)
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(Color(SUB_TEXT_COLOR))
                .frame(width: TEXT_VERIFY_WIDTH, height: TEXT_VERIFY_HEIGHT)
                .padding(.top, MARGIN_MEDIUM_1)
        }
    }
}
