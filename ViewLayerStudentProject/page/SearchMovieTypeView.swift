//
//  SwiftUIView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/12.
//

import SwiftUI

struct SearchMovieTypeView: View {
    
    @State var text: String = ""
    @State var placeholder: String = "search the movie"
    @State var expand = false
    @State var expand1 = false

    @State var expand2 = false
    @State var movieId: Int = 0
    @State var onTapMovie: Bool = false
    @State var currentSelection = MovieType.MOVIE_CURRENT.rawValue
    @State var showDetails = false
    
    var body: some View {
        ZStack{
            Color(BG_COLOR)
            
            
            VStack(alignment: .leading) {
                // App Bar
                SearchAppBarView(text: $text, placeholder: placeholder)
                    .padding(.top, MARGIN_XBIG - MARGIN_MEDIUM_2)
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    
                    HStack {
                        ForEach(0...2, id: \.self){ val in
                            VStack {
                                
                                ZStack {
                                    HStack {
                                        Text("Genres\(val)")
                                            .font(.system(size: MARGIN_HALF_LARGE))
                                            .foregroundColor(Color(.black))
                                            .fontWeight(.bold)
                                            .padding(.trailing, MARGIN_MEDIUM)
                                        
                                        Image(systemName: IC_CHEV_DOWN)
                                            .resizable()
                                            .frame(width: MARGIN_MEDIUM, height: MARGIN_SMALL + 1)
                                            .fontWeight(.bold)
                                    }
                                    .onTapGesture {
                                        if val == 0 {
                                            self.expand.toggle()
                                        } else if val == 1 {
                                            self.expand1.toggle()
                                        } else {
                                            self.expand2.toggle()
                                        }
                                }
                                    if expand && val == 0 {
                                        VStack{
                                            Text("Dropdown 1")
                                            Text("Dropdown 2")
                                        }
                                        .background(Color(.white))
                                        .cornerRadius(MARGIN_MEDIUM_1)
                                        .animation(.spring(), value: 1)
                                        
                                    } else if expand1 && val == 1{
                                        Text("Row number two")
                                        Text("Dropdown")
                                    } else if expand2 && val == 2{
                                        Text("Dropdown")
                                        Text("Item for list")
                                    }
                                }
                               
                            }
                            .padding(MARGIN_MEDIUM_1)
                            .background(Color(.white))
                            .cornerRadius(MARGIN_MEDIUM_1)
                            .animation(.spring(), value: 1)
                            .alignmentGuide(VerticalAlignment.bottom) {
                                $0[.top]
                            }
                            .padding(.trailing, MARGIN_MEDIUM_2)
                        }
                    }
                    .padding([.leading, .top], MARGIN_MEDIUM_2)
                    .zIndex(10)

                   
                    // search result list
                    
                    MovieGridView(movieId: $movieId, onTapMovie: $onTapMovie, sectionName: currentSelection, mMovies: [MovieVO]())
                    .padding(.top, MARGIN_XXLARGE + MARGIN_LARGE)
                    // onTapMovie: {
//                    showDetails = true
//                }, sectionName: currentSelection
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(0...10, id: \.self){ _ in
//                                Image(POSTER_IMAGE)
//                                    .resizable()
//                                    .frame(width: 171, height: 279)
//                                    .padding(.top, MARGIN_XXLARGE + MARGIN_LARGE)
//                                    .zIndex(1)
//                            }
//                        }
//                    }
                 
                }
               
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea([.top,.bottom])
    }
}

struct SearchMovieTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovieTypeView()
    }
}

struct SearchAppBarView: View {
    
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack(spacing: MARGIN_MEDIUM_2){
            Image(systemName: IC_CHEV_LEFT)
                .resizable()
                .frame(width: MARGIN_MEDIUM_2 - 3, height: MARGIN_LARGE - 2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: MARGIN_LARGE - 2, height: MARGIN_LARGE - 2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ZStack(alignment: .leading){
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(SUB_TEXT_COLOR))
                        .font(.system(size:MARGIN_MEDIUM_2))
                        .padding(.leading, MARGIN_CARD_MEDIUM_2)
                }
                TextField("", text: $text)
                    .padding(.leading, MARGIN_CARD_MEDIUM_2)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .frame(height: TEXT_FIELD_HEIGHT)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.phonePad)
                
            }
            
            Image(systemName: IC_ELLIPSIS_CIRCLE)
                .resizable()
                .frame(width: MARGIN_LARGE - 2, height: MARGIN_LARGE - 2)
                .foregroundColor(Color(PRIMARY_COLOR))
                .fontWeight(.bold)
            
        }
        .padding([.leading, .trailing], MARGIN_MEDIUM_2)
    }
}
