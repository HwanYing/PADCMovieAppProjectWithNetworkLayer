//
//  WrappedLayoutView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import Foundation
import SwiftUI

struct WrappedLayoutView: View {

//    let movieData: [MovieInfoVO] = dummyMovieInfo
    var movieData: MovieVO?

    var body: some View {
        ZStack {
            GeometryReader { geo in
                self.generateContent(in: geo)
                   
            }
        }
    }
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {

//            ForEach(movieData) { movieData in
            ForEach(movieData?.genres ?? [], id: \.self){ genre in
                    Text(genre)
                        .foregroundColor(.black)
                        .font(.system(size: MARGIN_CARD_MEDIUM_2))
                        .padding([.leading, .trailing], MARGIN_MEDIUM)
                        .padding([.top, .bottom], MARGIN_SMALL)
                        .background(Color(PRIMARY_COLOR))
                        .cornerRadius(MARGIN_MEDIUM_1)
                        .padding([.top, .trailing], MARGIN_MEDIUM)
                        .alignmentGuide(.leading) { showing in
                            if(abs(width - showing.width) > g.size.width) {
                                width = 0
                                height -= showing.height
                            }
                            let result = width
                            if genre == movieData?.genres?.last! {
                                width = 0 // last item
                            } else {
                                width -= showing.width
                            }
                            return result
                        }
                        .alignmentGuide(.top, computeValue: { showing in
                            let result = height
                            if genre == movieData?.genres?.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                }
//            }
        }
    }
    func item(for text: String) -> some View {
        Text(text)
            .foregroundColor(.black)
            .font(.system(size: MARGIN_CARD_MEDIUM_2))
            .padding([.leading, .trailing], MARGIN_MEDIUM)
            .padding([.top, .bottom], MARGIN_SMALL)
            .background(Color(PRIMARY_COLOR))
            .cornerRadius(MARGIN_MEDIUM_1)
    }
}
