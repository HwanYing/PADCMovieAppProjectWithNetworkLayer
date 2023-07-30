//
//  AboutCSMovieView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import SwiftUI

struct AboutCSMovieView: View {
    
//    @Binding var showDetails : Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            //background color
            Color(BG_COLOR)
            
            ScrollView {
                
                VStack(spacing: 0.0) {
                    
                    // Video Trailer View
//                    MovieTrailerView(onTapBack: {
//                        dismiss()
//                        showDetails = false
//                    })
//                    .padding(.top, MARGIN_XXLARGE)
                    // Movie Poster, Rating, Genre
                    MovieGenreRatingView()
                    
                    // Release date, duration, censor
                    ReleasedSectionView()
                    
                    // Timing Section
                    TimingSectionView()
                    
                    
                    // StoryLine
                    StoryLineView()
                    
                    // Cast View
                    CastListView()
                }
                .padding(.bottom, MARGIN_XBIG + MARGIN_XXLARGE)

            }
            .navigationBarBackButtonHidden(true)
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct AboutCSMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AboutCSMovieView()
    }
}

struct TimingSectionView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 0.0) {
                Text(COMING_RELEASE_DATE)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(NOTI_MESSAGE)
                    .font(.system(size: MARGIN_HALF_LARGE))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(SUB_NOTE_COLOR))
                    .padding(.top, MARGIN_MEDIUM_1)
                
                HStack{
                    // Noti Icon
                    Image(systemName: IC_WAVE_NOTI)
                        .resizable()
                        .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                        .foregroundColor(.black)
                    
                    // Noti Message
                    Text(NOTI_BTN_TEXT)
                        .foregroundColor(.black)
                        .font(.system(size: MARGIN_HALF_LARGE))
                }
                .padding(MARGIN_MEDIUM)
                .background(Color(PRIMARY_COLOR))
                .cornerRadius(MARGIN_MEDIUM)
                .padding(.top, MARGIN_MEDIUM_4)
            }
            
            Spacer()
            
            // Icon
            Image(NOTI_IMAGE)
                .resizable()
                .frame(width: COMING_IMAGE_WIDTH, height: COMING_IMAGE_HEIGHT)
                .padding(.leading, MARGIN_LARGE)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - MARGIN_XLARGE)
        .background(Color(SECTION_BG_COLOR))
        .cornerRadius(MARGIN_MEDIUM)
        .padding(EdgeInsets(top: MARGIN_XLARGE, leading: MARGIN_MEDIUM_1, bottom: 0, trailing: MARGIN_MEDIUM_1))
    }
}
