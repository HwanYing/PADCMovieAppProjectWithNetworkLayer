//
//  AboutComingSoonView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import SwiftUI
import AVKit

struct AboutNSMovieView: View {
    
    @Environment(\.dismiss) var dismiss
    //    @Binding var selection: String
    let mModel: MovieModel = MovieModelImpl.shared
    var movieId: Int?
    var section: String?
    var cityName: String?
    @State var movieDetails: MovieVO? = nil
    @State var isBooking: Bool = false
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack{
    
                        // Video Trailer View
                        VStack(alignment: .leading, spacing: 0.0) {
                            VideoPlayer(player: AVPlayer(url: URL(string: VIDEO_URL)!))
                                .frame(height: MOVIE_TRAILER_HEIGHT)
    
                            Spacer()
                        }
                        
//                         Back Button
                        BackButtonSectionView(){
                            dismiss()
                        }
                      

                        VStack {


                            Spacer()


                            // Poster Image, Rating , Genre
                            MovieGenreRatingView(movie: movieDetails)
                                .frame(height: POSTER_IMAGE_HEIGHT)
                        }
                        
                    }
                    .frame(height: MOVIE_TRAILER_HEIGHT+POSTER_IMAGE_HEIGHT-MARGIN_XLARGE)

                    
//                    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                        
                            VStack(spacing: 0.0) {
                                
                                // Release date, duration, censor
                                ReleasedSectionView(releaseDate: movieDetails?.releaseDate, runtime: movieDetails?.runtime)
                                
                                if (section != NOW_PLAYING_MOVIE) {
                                    // Timing Section
                                    TimingSectionView()
                                }
                                
                                // StoryLine
                                StoryLineView(overview: movieDetails?.overview ?? "")
                                
                                // Cast list section
                                CastListView(castList: movieDetails?.casts)
                            }
                            .padding(.bottom, MARGIN_XBIG + MARGIN_XXLARGE)
                            
                        
//                        // Booking Floating Button
//                        BookingButtonView()
                        
//                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            .padding(.top, MARGIN_XXLARGE)
            
            // LinearGradient
//            LinearGradient(colors: [.clear,.clear,.clear,.clear,.black.opacity(0.6),.black], startPoint: .top, endPoint: .bottom)
            
            if (section == NOW_PLAYING_MOVIE) {
                // Booking Floating Button
                BookingButtonView(isBooking: $isBooking)
            }
           
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .background(Color(BG_COLOR))
        .fullScreenCover(isPresented: $isBooking, content: {
            TimeSlotScreenView(movieId: movieId, cityName: cityName, movieName: movieDetails?.originalTitle, posterImageLink: movieDetails?.getPosterPathTogetherWithBaseURL())
        })
//        .navigationDestination(for: String.self, destination: { value in
//            if (value == "GoToTimeSlotSection") {
//
//            }
//        })
        .onAppear(){
            requestData()
        }
    }
    func requestData() {
        debugPrint("Movie ID===> \(movieId ?? 0)")
        mModel.getMovieDetails(id: movieId ?? 0) { movie in
            self.movieDetails = movie
        } onFailure: { error in
            debugPrint(error)
        }
        
    }
}

struct AboutNSMovieView_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutNSMovieView()
    }
}

struct MovieGenreRatingView: View {
    
    var movie: MovieVO?
    
    var body: some View {
        HStack{
            Spacer()
            // Poster Image
            DetailsPosterImageView(imageUrl: movie?.getPosterPathTogetherWithBaseURL() ?? "")
                .padding(.leading, MARGIN_SMALL)
            
            Spacer()
            VStack(alignment: .leading, spacing: 0.0){
                
                Spacer()
                
                // Title, Image, Rating
                HStack{
                    // Movie Title
                    Text(movie?.originalTitle ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: MARGIN_MEDIUM_2))
                        .fontWeight(.bold)
                        .lineLimit(2)
                    
                    // Image
                    Image(IMDB_IMAGE)
                        .resizable()
                        .frame(width: MARGIN_XLARGE, height: MARGIN_MEDIUM_4)
                    
                    // Rating Text
                    Text(String(format: "%.2f", Double(movie?.rating ?? 0.0)))
                        .font(.system(size: MARGIN_CARD_MEDIUM_2))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(.top, MARGIN_XLARGE)
                // Watching Type
                Text("2D, 3D, 3DIMAX, 3D DBOX")
                    .foregroundColor(.white)
                    .font(.system(size: MARGIN_HALF_LARGE))
                    .fontWeight(.bold)
                    .padding(.top, MARGIN_MEDIUM_2)
                    .padding(.bottom, MARGIN_MEDIUM_1)
                // Movie Type
                WrappedLayoutView(movieData: movie)
//                    .frame(height: POSTER_IMAGE_HEIGHT-MARGIN_XBIG)
            }
            .padding(.bottom, MARGIN_SMALL)
//            .frame(width: UIScreen.main.bounds.width - POSTER_IMAGE_WIDTH - MARGIN_LARGE)
//            .padding(.leading, -MARGIN_MEDIUM_1)
            Spacer()
        }
//        .frame(width: UIScreen.main.bounds.width - MARGIN_LARGE, height: POSTER_IMAGE_HEIGHT)
        //        .offset(y: -MARGIN_LARGE)
    }
}

struct MovieInfoSubView: View {
    
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: MARGIN_CARD_MEDIUM_2))
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            Text(value)
                .font(.system(size: MARGIN_HALF_LARGE))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, MARGIN_MEDIUM)
        }
        .padding()
        .background(Color(.black).opacity(0.4))
        .cornerRadius(MARGIN_MEDIUM_1)
        .shadow(color: Color(SECTION_BG_COLOR), radius: MARGIN_LARGE)
    }
}

struct StoryLineView: View {
    
    var overview: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0){
            HStack {
                Text(STORY_LINE_TITLE)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .foregroundColor(.white)
                .fontWeight(.bold)
                Spacer()
            }
            
            Text(overview ?? "")
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.white)
                .padding(.top, MARGIN_MEDIUM_1)
        }
        .padding(EdgeInsets(top: MARGIN_XLARGE, leading: MARGIN_MEDIUM_2, bottom: 0, trailing: MARGIN_MEDIUM_2))
    }
}

struct BookingButtonView: View {
    
    @Binding var isBooking: Bool
    
    var body: some View {
        
        ZStack {
            // LinearGradient
            LinearGradient(colors: [.clear,.clear,.black.opacity(0.8),.black.opacity(0.95),.black], startPoint: .top, endPoint: .bottom)
            
            VStack{
                
                Spacer(minLength: MARGIN_XLARGE)
                
                // Booking Button ... jul26
//                NavigationLink(value: "GoToTimeSlotSection") {
                    BottomFloatingBtnView(text: BOOKING_BTN_LABEL)
                    .onTapGesture {
                        self.isBooking = true
                    }
//                }
                
            }
            .frame(width: BOOKING_BTN_WIDTH, height: BOOKING_BTN_HEIGHT)
        }
        .frame(maxHeight: IMAGE_HEIGHT)
        
    }
}

struct CastListView: View {
    
    var castList: [ActorVO]?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(CAST_LABEL)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_2))
                .fontWeight(.bold)
            
            // Actor list
            ScrollView(.horizontal) {
                HStack(spacing: MARGIN_MEDIUM_2) {
                    ForEach(castList ?? [], id: \.id){ cast in
                        VStack(spacing: 0.0) {
                            // Cast Image
                            CastImageView(imageUrl: cast.getProfilePathTogetherWithBaseURL())
                            
                            Text(cast.name ?? "")
                                .font(.system(size: MARGIN_MEDIUM_1))
                                .foregroundColor(.white)
                                .padding(.top, MARGIN_MEDIUM_2)
                        }
                        .padding(.top, MARGIN_LARGE)
                        
                    }
                }
            }
            
        }
        .padding(.top, MARGIN_XLARGE)
        .padding(.leading, MARGIN_MEDIUM_2)
    }
}

struct HalfCircleView: View {
    
    var widthAndHeight: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.5)
            .fill(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8),.black.opacity(0.9), .black]), startPoint: .top, endPoint: .bottom))
            .frame(width: widthAndHeight, height: widthAndHeight)
    }
}

struct ReleasedSectionView: View {
    
    var releaseDate: String?
    var runtime: Int?
    
    var body: some View {
        HStack{
            MovieInfoSubView(title: LABEL_ONE, value: LABEL_ONE_VALUE)
            MovieInfoSubView(title: LABEL_TWO, value: releaseDate ?? "") // Release Data
            MovieInfoSubView(title: LABEL_THREE, value: changeFormatforDuration(time: runtime ?? 0)) // Duration
        }
        .padding(.top, MARGIN_MEDIUM_2)
    }
    func changeFormatforDuration(time: Int) -> String {
        var hour: Int = 0
        var min: Int = 0
        
        if (time > 60) {
            hour += time / 60;
            let diff = (time - (hour*60))
            if (diff > 60) {
                min += diff/60
            } else {
                min += (time - (hour*60))
            }
        }
        var result = ""
        if (min > 1) {
            result = "\(min)mins"
        } else {
            result = "\(min)min"
        }
        return "\(hour)hr \(result)"
    }
}

struct BottomFloatingBtnView: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            
            Text(text)
                .font(.system(size: MARGIN_MEDIUM_2))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding()
                .frame(width: BOOKING_BTN_WIDTH, height: BOOKING_BTN_HEIGHT)
                .background(Color(PRIMARY_COLOR))
                .cornerRadius(MARGIN_MEDIUM_1)
            
            HStack {
                
                HalfCircleView(widthAndHeight: MARGIN_MEDIUM_4)
                    .rotationEffect(Angle(degrees: -CIRCLE_ROTATE_DEGREE))
                
                Spacer()
                
                HalfCircleView(widthAndHeight: MARGIN_MEDIUM_4)
                    .rotationEffect(Angle(degrees: CIRCLE_ROTATE_DEGREE))
            }
            .frame(width: BOOKING_BTN_WIDTH + MARGIN_MEDIUM_4)
        }
    }
}
struct CastImageView: View {
    
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
                    .frame(width: MARGIN_XBIG, height: MARGIN_XBIG)
                    .cornerRadius(MARGIN_SXLARGE)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                EmptyView()
            }
        }
        
    }
}

struct BackButtonSectionView: View {
    
    var onTapBack: () -> Void = {}

    var body: some View {
        VStack{
            HStack{
                Image(systemName: IC_BACK_BUTTON)
                    .resizable()
                    .frame(width: MARGIN_HALF_LARGE, height: MARGIN_LARGE)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .onTapGesture {
                        onTapBack()
                    }
                
                Spacer()
                
                Image(SHARE_IMAGE)
                    .resizable()
                    .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                
            }
            .padding(EdgeInsets(top: MARGIN_XLARGE, leading: MARGIN_LARGE, bottom: 0, trailing: MARGIN_LARGE))
            
            Spacer()
        }
    }
}
