//
//  CinemaTabMainView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/18.
//

import SwiftUI

struct CinemaTabMainView: View {
    
    let data: [DropdownItemVO] = dropDownData
    @State var searchValue = ""
    @State var placeholder = "search the movie"
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0){
                        // app bar
                        CinemaAppBarView(searchValue: $searchValue, holder: $placeholder)
                    
                        // dropdown filter
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                        HStack(spacing: 0.0) {
                            MovieSelectionDataView(defaultTitle: "Genres")
                            .zIndex(MARGIN_MEDIUM_2)
                            
                            MovieSelectionDataView(defaultTitle: "Format")
                                .zIndex(MARGIN_MEDIUM_4)
                            
                            MovieSelectionDataView(defaultTitle: "Month")
                                .zIndex(MARGIN_LARGE)
                        }
                        .padding([.leading,.top], MARGIN_MEDIUM_2)
                        .zIndex(MARGIN_XBIG)
                        // grid view section
                        MovieGridView(sectionName: "", movies: [MovieVO]())
                            .buttonStyle(.plain)
                            .padding(.top, MARGIN_XBIG - MARGIN_MEDIUM)
                    }
                      
                }
                .background(Color(BG_COLOR))
            }
        }
            
    }
}

struct CinemaTabMainView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaTabMainView()
    }
}

struct CinemaAppBarView: View {
    
    @Binding var searchValue: String
    @Binding var holder: String
    
    var body: some View {
        HStack{
            // back icon
            Image(systemName: IC_CHEV_LEFT)
                .resizable()
                .frame(width: MARGIN_CARD_MEDIUM_2, height: MARGIN_LARGE - 2)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .clipped()
                .padding(.leading, MARGIN_LARGE)
            
            // serach icon
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: MARGIN_LARGE - 2, height: MARGIN_LARGE - 2)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .clipped()
                .padding(.leading, MARGIN_MEDIUM_2)
            
            // Search field
            CustomTextField(value: $searchValue, placeHolder: holder, bColor: Color(SUB_TEXT_COLOR), bottomColor: Color(.clear))
            
            Spacer()
            
            // Filter image
            Image(FILTER_IMAGE_PRIMARY)
                .resizable()
                .frame(width: MARGIN_LARGE - 2, height: MARGIN_LARGE - 2)
                .clipped()
                .padding(.trailing, MARGIN_LARGE)
        }
    }
}
