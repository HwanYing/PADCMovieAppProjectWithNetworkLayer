//
//  MovieCardView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import SwiftUI

struct MovieCardView: View {
    
    var mMovie: MovieVO?
    var section: String?
    
    let now = Date.now
    let tomorrow = Date.now.addingTimeInterval(86400)
    let nextDay = Date.now.addingTimeInterval(86400*5)
    @State var Datelabel = ""
    
    var body: some View {
        ZStack {
            // Image
            PosterImageView(imageUrl: mMovie?.getPosterPathTogetherWithBaseURL() ?? "")
                .padding(.bottom, MARGIN_XXLARGE)
            // Gradient Color
            LinearGradient(colors: [.clear,.clear, Color(.gray).opacity(0.4), Color(.black).opacity(0.5), Color(.black).opacity(0.7)], startPoint: .top, endPoint: .bottom)
            
            VStack {
                // Air Date
                if (section != NOW_PLAYING_MOVIE) {
                    HStack {
                        Spacer()
                        Text("\(Datelabel)th JULY")
                            .foregroundColor(Color(SECTION_BG_COLOR))
                            .font(.system(size: MARGIN_MEDIUM_1))
                            .fontWeight(.semibold)
                            .padding(MARGIN_SMALL)
                            .frame(width: MARGIN_XLARGE + MARGIN_SMALL, height: MARGIN_XLARGE)
                            .background(Color(PRIMARY_COLOR))
                            .cornerRadius(MARGIN_MEDIUM)
                            .padding([.top, .trailing], MARGIN_MEDIUM_1)
                    }
                }
               
                
                Spacer()
                
                // Title View
                VStack(alignment: .leading, spacing: 0.0) {
                    HStack{
                        // Title
                        Text(mMovie?.originalTitle ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: MARGIN_CARD_MEDIUM_2))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Spacer()
                        // Image
                        Image(IMDB_IMAGE)
                            .resizable()
                            .frame(width: MARGIN_XLARGE, height: MARGIN_MEDIUM_4)
                            .padding(.trailing, -MARGIN_MEDIUM)
                        
                        // Rating Text
                        Text("9.8")
                            .font(.system(size: MARGIN_CARD_MEDIUM_2))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.trailing, MARGIN_MEDIUM)
                    
                    // Movie Type
                    HStack{
                        Text(LABEL_ONE_VALUE)
                            .foregroundColor(.white)
                            .font(.system(size: MARGIN_CARD_MEDIUM_2))
                            .fontWeight(.semibold)
                        // dot image
                        Circle()
                            .foregroundColor(Color(CIRCLE_COLOR))
                            .frame(width: MARGIN_SMALL, height: MARGIN_SMALL)
                        Text("2D")
                            .foregroundColor(.white)
                            .font(.system(size: MARGIN_MEDIUM_1))
                    }
                    
                }
                .padding(EdgeInsets(top: MARGIN_CARD_MEDIUM_2, leading: MARGIN_MEDIUM, bottom: MARGIN_MEDIUM_4, trailing: MARGIN_MEDIUM))
            }
        }
        .frame(width: MOVIE_CARD_WIDTH, height: MOVIE_CARD_HEIGHT)
        .background(Color.black.opacity(0.6))
        .cornerRadius(MARGIN_MEDIUM)
        .onAppear(){
            createDateLabel()
        }
//        ZStack {
//
//            Color(.black)
//
//            VStack(alignment: .leading, spacing: 0.0){
//
//                // movie image
//                ZStack {
//
//                    PosterImageView(imageUrl: mMovie?.getPosterPathTogetherWithBaseURL() ?? "")
//
//                    // Gradient Color
//                    LinearGradient(colors: [.clear,.clear,.clear, Color(.black)], startPoint: .top, endPoint: .bottom)
//                }
//                    // Title View
//                    HStack{
//                        // Title
//                        Text(mMovie?.originalTitle ?? "")
//                            .foregroundColor(.white)
//                            .font(.system(size: MARGIN_CARD_MEDIUM_2))
//                            .fontWeight(.semibold)
//                            .lineLimit(1)
//
//                        Spacer()
//                        // Image
//                        Image(IMDB_IMAGE)
//                            .resizable()
//                            .frame(width: MARGIN_XLARGE, height: MARGIN_MEDIUM_4)
//                            .padding(.trailing, -MARGIN_MEDIUM)
//
//                        // Rating Text
//                        Text("9.0")
//                            .font(.system(size: MARGIN_CARD_MEDIUM_2))
//                            .foregroundColor(.white)
//                            .fontWeight(.semibold)
//
//                    }
//                    .padding([.leading, .trailing], MARGIN_MEDIUM)
//
//                    // Movie Type
//                    HStack{
//                        Text(LABEL_ONE_VALUE)
//                            .foregroundColor(.white)
//                            .font(.system(size: MARGIN_CARD_MEDIUM_2))
//                            .fontWeight(.semibold)
//                        // dot image
//                        Circle()
//                            .foregroundColor(Color(CIRCLE_COLOR))
//                            .frame(width: MARGIN_SMALL, height: MARGIN_SMALL)
//                        Text("2D, 3D, 3D IMAX")
//                            .foregroundColor(.white)
//                            .font(.system(size: MARGIN_MEDIUM_1))
//                    }
//                    .padding(EdgeInsets(top: MARGIN_CARD_MEDIUM_2, leading: MARGIN_MEDIUM, bottom: MARGIN_MEDIUM_4, trailing: MARGIN_MEDIUM))
//                }
//
//        }
//        .frame(width: MOVIE_CARD_WIDTH, height: MOVIE_CARD_HEIGHT)
//        .cornerRadius(MARGIN_MEDIUM)
    }
    func createDateLabel() {
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: nextDay)
        //        let hour = components.hour ?? 0
        //        let minute = components.minute ?? 0
        let day = components.day ?? 1
        Datelabel = "\(day)"
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView()
//            .previewLayout(.fixed(width: 171, height: 279))
    }
}


struct PosterImageView: View {
    
    var imageUrl: String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)){ phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, idealWidth: MOVIE_CARD_WIDTH, maxWidth: MOVIE_CARD_WIDTH, minHeight: 0, idealHeight: MOVIE_CARD_HEIGHT, maxHeight: MOVIE_CARD_HEIGHT)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                EmptyView()
            }
        }
        
    }
}
