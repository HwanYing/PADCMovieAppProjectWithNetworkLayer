//
//  MovieGridView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import SwiftUI

struct MovieGridView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var sectionName: String?
    var mMovies: [MovieVO]?
    //    var onTapMovie: () -> Void = {}
    //
    //    init(onTapMovie: @escaping () -> Void, sectionName: String) {
    //        self.onTapMovie = onTapMovie
    //        self.sectionName = sectionName
    //    }
    init(sectionName: String, movies: [MovieVO]?) {
        self.sectionName = sectionName
        self.mMovies = movies
    }
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: MARGIN_MEDIUM_4) {
                ForEach(mMovies ?? [], id: \.id) { movie in
//                    NavigationLink(value: sectionName == MovieType.MOVIE_CURRENT.rawValue ? ViewOptionsRoute.movieDetailsNS : ViewOptionsRoute.movieDetailsCS){
//                        if sectionName == MovieType.MOVIE_CURRENT.rawValue {
                    NavigationLink(value: movie) {
                        MovieCardView(mMovie: movie, section: sectionName)
                            }
//                        } else {
//                            NavigationLink(value: "ComingSoon") {
//                                ComingSoonCardView(movie: movie)
//                            }
//                        }
                        
//                    }
                }
            }
            .padding([.leading, .trailing], MARGIN_MEDIUM_1)
        }
    }
}

struct MovieGridView_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieGridView(sectionName: "", movies: [MovieVO]())
    }
}

struct GridStack<Content: View>: View {
    
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self){ row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
