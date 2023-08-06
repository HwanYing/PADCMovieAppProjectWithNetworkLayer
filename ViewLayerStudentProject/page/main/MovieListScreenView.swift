//
//  MovieListScreenView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/4.
//

import SwiftUI

struct MovieListScreenView: View {
    
    let mModel: MovieModel = MovieModelImpl.shared
    
    @State var currentSelection = NOW_PLAYING_MOVIE
    @State var showDetails = false
    @State var bannerMovies: [MovieVO]? = nil
    @State var movieList: [MovieVO]? = nil
    @State var movieId: Int = 0
    @State var onTapMovie: Bool = false
    @Binding var region: String

    var body: some View {
        ZStack {
            Color(BG_COLOR)
            
            VStack{
                // App Bar
                AppBarView(region: $region)
                
                ScrollView{
                    // Banner View
                    MovieBannerView(bannerMovies: bannerMovies, onTapMovie: {
                        
                    })
                    
                    // Movie Selection
                    MovieSelectionView(selection: $currentSelection)
                        .onChange(of: currentSelection) { newValue in
                            if (newValue == "Now Playing") {
                                self.getMoviesByType(type: "current")
                            } else if (newValue == "Coming Soon"){
                                self.getMoviesByType(type: "comingsoon")
                            }
                        }
                    
                    // Movie Grid Section
                    MovieGridView(movieId: $movieId, onTapMovie: $onTapMovie, sectionName: currentSelection, mMovies: movieList)
                        .padding(.top, MARGIN_MEDIUM_2)
                    
                }
                .padding(.bottom, MARGIN_XBIG)
            }
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .onAppear(){
            requestBannerData()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $onTapMovie, destination: {
            AboutNSMovieView(movieId: self.movieId, section: currentSelection, cityName: region)
        })
//        .navigationDestination(for: MovieVO.self) { movie in
//            AboutNSMovieView(movieId: movie.id, section: currentSelection, cityName: region)
//        }
        
    }
    func requestBannerData() {
        mModel.getBannerMovies { movies in
            debugPrint(movies)
            self.bannerMovies = movies
            self.getMoviesByType(type: MovieType.MOVIE_CURRENT.rawValue)
        } onFailure: { error in
            debugPrint(error)
        }
    }
    
    func getMoviesByType(type: String) {
        print("Section click ===> \(type)")
        mModel.getMoviesByType(type: type) { movies in
            self.movieList = movies
        } onFailure: { error in
            debugPrint(error)
        }
        
    }
}

struct MovieListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListScreenView(region: .constant(""))
    }
}

struct AppBarView: View {
    
    @Binding var region: String
    
    var body: some View {
        HStack{
            // location icon
            Image(systemName: IC_LOCATION)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2, height: MARGIN_MEDIUM_2)
                .foregroundColor(.white)
            
            // Location
            Text(region)
                .foregroundColor(.white)
                .font(.system(size: MARGIN_MEDIUM_3))
                .fontWeight(.bold)
            
            Spacer()
            
            // search icon
            Image(systemName: IC_SEARCH)
                .foregroundColor(.white)
            
            Image(systemName: IC_NOTIFICATION)
                .foregroundColor(.white)
            
            Image(systemName: IC_SCAN_FINDER)
                .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: TEXT_XBIG, leading: MARGIN_CARD_MEDIUM_2, bottom: 0, trailing: MARGIN_CARD_MEDIUM_2))
        
    }
}


struct MovieSelectionView: View {
    
    @State var movieSection: [MovieSectionVO] = movieSectionData
    @Binding var selection: String
    
    var body: some View {
        HStack {
            ForEach(movieSection) { section in
                Text(section.sectionName)
                    .foregroundColor(Color(SUB_TEXT_COLOR))
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: MARGIN_MEDIUM_1, leading: MARGIN_LARGE, bottom: MARGIN_MEDIUM_1, trailing: MARGIN_LARGE))
                    .frame(width: (UIScreen.main.bounds.width - MARGIN_XXLARGE) / 2, height: MARGIN_MEDIUM_4 * 2)
                    .background(section.sectionName == selection ? Color(PRIMARY_COLOR) : Color(.clear))
                    .cornerRadius(MARGIN_MEDIUM)
                    .onTapGesture {
                        selection = section.sectionName
                    }
            }
        }
        .padding(8)
        .frame(width: UIScreen.main.bounds.width - MARGIN_LARGE, height: MARGIN_XXLARGE + MARGIN_MEDIUM)
        .background(Color(SECTION_ICON_COLOR))
        .cornerRadius(MARGIN_MEDIUM)
        //        .padding(.top, MARGIN_MEDIUM)
    }
}

struct MovieBannerView: View {
    
    var bannerMovies: [MovieVO]?
    var onTapMovie: () -> Void = {}
    
    //    init(onTapMovie: @escaping () -> Void) {
    init(bannerMovies: [MovieVO]?, onTapMovie: @escaping () -> Void) {
        self.bannerMovies = bannerMovies
        self.onTapMovie = onTapMovie
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color(PRIMARY_COLOR))
        UIPageControl.appearance().pageIndicatorTintColor = .gray
    }
    
    var body: some View {
        if (bannerMovies?.isEmpty ?? true) {
            EmptyView()
        } else {
            TabView {
                ForEach(bannerMovies ?? [], id: \.id) { movie in
                    
                    BannerImageView(imageUrl: movie.imageUrl ?? "")
                        .padding(.bottom, MARGIN_XXLARGE)
                        .onTapGesture {
                            onTapMovie()
                        }
                    
                }
            }
            .tabViewStyle(.page)
            .frame(height: BANNER_HEIGHT)
        }
        
    }
}


struct BannerImageView: View {
    
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
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: BANNER_HEIGHT, maxHeight: BANNER_HEIGHT)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                EmptyView()
            }
        }
        
    }
}
