//
//  PaymentPageVeiw.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/10.
//

import SwiftUI

struct PaymentPageVeiw: View {
    
    @State var placeholder: String = "Enter Your Name"
    @State var text: String = ""
    @State var width = CGFloat.zero
    @State var labelWidth = CGFloat.zero
//    let paymentList : [PaymentTypeVO] = paymentTypeData
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // background color
            Color(BG_COLOR)
            
            VStack(alignment: .leading, spacing: 0.0) {
                // payment bar section
                PaymentAppBarView(){
                    dismiss()
                }.padding(.top, MARGIN_XBIG - MARGIN_MEDIUM)
                
                // Text Field section
                CustomNewTextField(text: $text, placeholder: placeholder, width: $width, labelWidth: $labelWidth)
                    .padding(EdgeInsets(top: MARGIN_XLARGE, leading: MARGIN_SXLARGE, bottom: 0, trailing: MARGIN_SXLARGE))
                // button section
                OfferOrApplyBtnView()
                    .padding(.top, MARGIN_XLARGE)
                
                // payment section
                PaymentListSectionView()
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarBackButtonHidden(true)
    }
}

struct PaymentPageVeiw_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPageVeiw()
    }
}

struct PaymentAppBarView: View {
    
    var onTapBack: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 0.0){
            Image(systemName: IC_CHEV_LEFT)
                .resizable()
                .frame(width: MARGIN_HALF_LARGE, height: MARGIN_LARGE - 2)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.leading, MARGIN_MEDIUM_4)
                .onTapGesture {
                    onTapBack()
                }
            
            Spacer()
            
            Text(PAYMENT_MAIN_TITLE)
                .font(.system(size: MARGIN_LARGE - 2))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.leading, -MARGIN_LARGE)
            Spacer()
        }
    }
}

struct CustomNewTextField: View {
    
    @Binding var text: String
    var placeholder: String
    @Binding var width: CGFloat
    @Binding var labelWidth: CGFloat
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(SUB_TEXT_COLOR))
                    .font(.system(size:MARGIN_MEDIUM_2))
                    .padding(.leading, MARGIN_CARD_MEDIUM_2)
            }
            
            TextField("", text: $text)
                .foregroundColor(.white)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(EdgeInsets(top: MARGIN_HALF_LARGE, leading: MARGIN_MEDIUM_1, bottom: MARGIN_HALF_LARGE, trailing: MARGIN_MEDIUM_1))
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: MARGIN_SMALL + 1)
                            .trim(from: 0, to: 0.55)
                            .stroke(Color(PRIMARY_COLOR), lineWidth: 1)
                        
                        RoundedRectangle(cornerRadius: MARGIN_SMALL + 1)
                            .trim(from: 0.565 + (0.44 * (labelWidth / width)), to: 1)
                            .stroke(Color(PRIMARY_COLOR), lineWidth: 1)
                        Text(TOP_USER_NAME_HOLDER)
                            .foregroundColor(Color(PRIMARY_COLOR))
                            .overlay(GeometryReader { geo in
                                Color.clear.onAppear(){
                                    labelWidth = geo.size.width
                                }
                            })
                            .padding(MARGIN_SMALL / 2)
                            .font(.system(size: MARGIN_HALF_LARGE))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .offset(x: MARGIN_LARGE - MARGIN_SMALL, y: -MARGIN_MEDIUM_1)
                    }
                }
                .overlay(GeometryReader { geo in
                    Color.clear.onAppear(){ width = geo.size.width }
                })
                .onChange(of: width, perform: { newValue in
                    print("Width", newValue)
                })
                .onChange(of: labelWidth, perform: { _ in
                    print("LabelWidth", labelWidth)
                })
        }
        
    }
}

struct OfferOrApplyBtnView: View {
        
    var body: some View {
        HStack{
            Image(BXS_OFFER_IMG)
                .resizable()
                .frame(width: MARGIN_MEDIUM_4, height: MARGIN_MEDIUM_4)
            
            Text(OFFER_OR_APPLY_PROMO_TEXT)
                .font(.system(size: MARGIN_HALF_LARGE))
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding(MARGIN_MEDIUM_1)
        .frame(width: UIScreen.main.bounds.width - (MARGIN_SXLARGE * 2))
        .background(Color(PRIMARY_COLOR))
        .cornerRadius(MARGIN_MEDIUM)
        .padding(.leading, MARGIN_SXLARGE)
        
    }
}

struct PaymentTypeView: View {
    
    var paymentName: String
    var image: String
    
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .frame(width: MARGIN_XLARGE - 2, height: MARGIN_XLARGE - 2)
                .padding(.leading, MARGIN_MEDIUM - 2)
            
            Text(paymentName)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_HALF_LARGE))
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: IC_CHEV_RIGHT)
                .resizable()
                .frame(width: MARGIN_MEDIUM, height: MARGIN_HALF_LARGE)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.trailing, MARGIN_MEDIUM_2)
        }
        .padding(MARGIN_MEDIUM_1)
        .overlay(RoundedRectangle(cornerRadius: MARGIN_MEDIUM).stroke(Color(SUB_TEXT_COLOR).opacity(0.6),lineWidth: 1))
    }
}

struct PaymentListSectionView: View {
    
//    var paymentList: [PaymentTypeVO]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(PAYMENT_SECTION_TITLE)
                .font(.system(size: MARGIN_MEDIUM_3))
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.bold)
//            ForEach(0..<paymentList.count, id: \.self) { i in
//                NavigationLink(value: ViewOptionsRoute.paymentSuccess) {
//                    PaymentTypeView(paymentName: paymentList[i].paymentType, image: paymentList[i].image)
//                        .padding(.top, MARGIN_MEDIUM_1)
//                }
//
//            }
        }
        .padding(.top, MARGIN_XLARGE)
        .padding([.leading, .trailing], MARGIN_MEDIUM_2)
    }
}
