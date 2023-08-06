//
//  TicketInformationConfirmView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/11.
//

import SwiftUI

struct TicketInformationConfirmView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var movieTitle: String?
    var ticketCount: Int?
    var place: String?
    var ticketResult: CheckOutVO?
    var date: String?
    var startTime: String?
    var posterImageLink: String?
    
    var body: some View {
        ZStack {
            //background color
            Color(BG_COLOR)
            
            // Ticket result section
            TicketResultView(ticketCount: ticketCount, movieTitle: movieTitle, place: place, ticketResult: ticketResult, date: date, startTime: startTime, posterImageLink: posterImageLink){

            }
            
            // booking success image
            BookingSuccesView()
            
        }
        .edgesIgnoringSafeArea([.top,.bottom])
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            print("Poster image ===> \(posterImageLink ?? "")")
        }
    }
}

struct TicketInformationConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        TicketInformationConfirmView()
    }
}
struct QRGeneratorView: View {
    
    var text: String
    
    var body: some View {
        VStack {
            // qrcode image
            Image(uiImage: UIImage(data: getQRCodeDate(text: text)!)!)
                .resizable()
                .frame(width: BOOKING_RESULT_IMG_WIDTH, height: BOOKING_RESULT_IMG_WIDTH)
        }
    }
    
    func getQRCodeDate(text: String) -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = text.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: MARGIN_MEDIUM_1, y: MARGIN_MEDIUM_1)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
}

struct MovieInfoSectionOneView: View {
    
    var ticketCount: Int?
    var movieTitle: String?
    var place: String?
    var ticketName: String?
    var date: String?
    var startTime: String?
    var posterImageLink: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack{
                // poster
                TicketConfirmImageView(imageUrl: posterImageLink ?? "")
                
                VStack(alignment: .leading, spacing: MARGIN_MEDIUM_2 - MARGIN_SMALL) {
                    HStack {
                        Text(movieTitle ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: MARGIN_MEDIUM_2))
                            .fontWeight(.bold)
//                        Text("(3D)(U/A)")
//                            .font(.system(size: MARGIN_HALF_LARGE))
//                            .foregroundColor(Color(SUB_NOTE_COLOR))
//                            .padding(.leading, -MARGIN_SMALL)
//                            .fontWeight(.bold)
                    }
                    Text(place ?? "")
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .foregroundColor(Color(PRIMARY_COLOR))
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(M_TICKET)
                            .foregroundColor(Color(SUB_TEXT_COLOR))
                        Text("\(ticketCount ?? 0)")
                            .foregroundColor(Color(PRIMARY_COLOR))
                            .padding([.leading,.trailing], -MARGIN_SMALL)
                        Text(")")
                            .foregroundColor(Color(SUB_TEXT_COLOR))
                    }
                    HStack {
                        Text(ticketName ?? "")
                            .font(.system(size: MARGIN_MEDIUM_2))
                            .foregroundColor(.white)
                        
//                        Text(SCREEN_NUMBER)
//                            .font(.system(size: MARGIN_MEDIUM_2))
//                            .foregroundColor(Color(SUB_TEXT_COLOR))
//                            .padding(.leading, -MARGIN_SMALL)
                    }
                    .fontWeight(.bold)
                    
                }
                .padding(.leading, MARGIN_MEDIUM_1)
                
                Spacer()
            }
            .padding(EdgeInsets(top: MARGIN_MEDIUM_2, leading: MARGIN_MEDIUM_2, bottom: 0, trailing: MARGIN_MEDIUM_2))
            
            ZStack {
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [MARGIN_MEDIUM]))
                    .frame(height: 1)
                    .foregroundColor(Color(SECTION_BG_COLOR).opacity(0.5))
                
                HStack {
                    HalfCircleView1(widthAndHeight: MARGIN_SXLARGE, color: BG_COLOR)
                        .rotationEffect(Angle(degrees: -CIRCLE_ROTATE_DEGREE))
                    Spacer()
                    
                    HalfCircleView1(widthAndHeight: MARGIN_SXLARGE, color: BG_COLOR)
                        .rotationEffect(Angle(degrees: CIRCLE_ROTATE_DEGREE))
                }
                .padding([.leading, .trailing], -MARGIN_MEDIUM_4)
                
            }
            .padding(.top, MARGIN_MEDIUM_2)
            
            // Date, time , place
            DateTimePlaceCombineView(date: date, startTime: startTime, place: place)
                .padding(EdgeInsets(top: -MARGIN_MEDIUM_2, leading: MARGIN_MEDIUM_2, bottom: MARGIN_MEDIUM_4, trailing: 0))
        }
        .background(LinearGradient(gradient: Gradient(colors: [ Color(BOOKING_BG_COLOR_1), Color(BOOKING_BG_COLOR_2).opacity(0.4),Color(BOOKING_BG_COLOR_2).opacity(0.3), Color(BOOKING_BG_COLOR_3).opacity(0.8),Color(SNACK_BG_COLOR)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(MARGIN_MEDIUM)
        .padding()
        .padding(.top, MARGIN_XLARGE)
    }
}

struct DoneButtonView: View {
    
    var onTapDoneBtn: () -> Void?
    
    var body: some View {
        Button(action: {
            // TODO: Go To Root Main ScreenView
            onTapDoneBtn()
        }, label: {
            Text(DONE_BTN_LABEL)
                .font(.system(size: MARGIN_MEDIUM_4))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(MARGIN_MEDIUM_1)
                .frame(width: DONE_BUTTON_WIDTH)
            
        })
        .background(Color(PRIMARY_COLOR))
        .cornerRadius(MARGIN_SMALL)
    }
}

struct TicketResultView: View {
    
    var ticketCount: Int?
    var movieTitle: String?
    var place: String?
    var ticketResult: CheckOutVO?
    var date: String?
    var startTime: String?
    var posterImageLink: String?
    var onTapDoneBtn: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .center,spacing: 0.0) {
            // Title
            Text(TICKET_INFORMATION_TITLE)
                .font(.system(size: MARGIN_MEDIUM_4))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, MARGIN_XBIG - MARGIN_SMALL)
            
            // movie info section
            MovieInfoSectionOneView(ticketCount: ticketCount, movieTitle: movieTitle, place: place, ticketName: ticketResult?.seat, date: date, startTime: startTime, posterImageLink: posterImageLink)
            
            QRGeneratorView(text: "Hello World")
                .padding(.top, MARGIN_XBIG - MARGIN_MEDIUM_2)
            
            Text("WAG5LP1C")
                .font(.system(size: MARGIN_MEDIUM_4))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, MARGIN_MEDIUM_2)
            
            HStack {
                Text("TPIN:")
                    .foregroundColor(Color(SUB_TEXT_COLOR))
                Text("WKCSL96")
                    .foregroundColor(.white)
            }
            .font(.system(size: MARGIN_MEDIUM_4))
            .fontWeight(.bold)
            .padding(.bottom, MARGIN_LARGE)
            
            // Done btn
            DoneButtonView(){
                onTapDoneBtn()
            }
               
            Spacer()
            
        }
    }
}

struct TicketConfirmImageView: View {
    
    var imageUrl: String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)){ phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .frame(width: BOOKING_RESULT_IMG_WIDTH, height: BOOKING_RESULT_IMG_HEIGHT)
                    .cornerRadius(MARGIN_SMALL)
//                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                EmptyView()
            }
        }
        
    }
}
