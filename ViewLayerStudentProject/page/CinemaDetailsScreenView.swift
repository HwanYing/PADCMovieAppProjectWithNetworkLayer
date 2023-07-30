//
//  CinemaDetailsScreenView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/22.
//

import SwiftUI
import AVKit

struct CinemaDetailsScreenView: View {
    var body: some View {
        ZStack {
            Color(BG_COLOR)
            VStack(alignment: .leading, spacing: 0) {
                // AppBar
                CinemaDetailsAppBar()
                
                // vdo trailer, location
                CinemaDetailsHeadView()

                // Facilities
                FacilitiesView()
                
                // Safety View
                
            }
            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct CinemaDetailsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaDetailsScreenView()
    }
}

// AppBar
struct CinemaDetailsAppBar: View {
    var body: some View {
        HStack{
            // back icon
            BackButtonSubView()
            
            Spacer()
            
            // details label
            Text(CINEMA_DETAILS_LABEL)
                .font(.system(size: MARGIN_LARGE - 2))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.leading, -MARGIN_LARGE)
            
            Spacer()
            
            Image(systemName: IC_STAR_NORMAL)
                .resizable()
                .frame(width: TEXT_SMALL_HEADING, height: TEXT_SMALL_HEADING)
                .foregroundColor(.white)
                .clipped()
        }
        .padding(.trailing, MARGIN_MEDIUM_4)
    }
}

// vdo trailer, location
struct CinemaDetailsHeadView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VideoPlayer(player: AVPlayer(url: URL(string: VIDEO_URL)!))
                .frame(height: CINEMA_DETAILS_VDO_HEIGHT)
            
            VStack(alignment: .leading, spacing: 0) {
                // cinema name label
                Text(CINEMA_NAME)
                    .font(.system(size: MARGIN_MEDIUM_2))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                // place
                HStack {
                    Text(LOCATION_LABEL)
                        .foregroundColor(.white)
                        .font(.system(size: MARGIN_MEDIUM_3))
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Image(systemName: IC_LOCATION)
                        .resizable()
                        .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                        .clipped()
                        .foregroundColor(Color(PRIMARY_COLOR))
                }
                .padding(.top, MARGIN_MEDIUM_2)
                
            }
            .padding(.top, MARGIN_LARGE)
            .padding([.leading,.trailing], MARGIN_MEDIUM_2)

        }
        .padding(.top, MARGIN_LARGE)
    }
}

// Facilities
struct FacilitiesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(FACILITIES_LABEL)
                .font(.system(size: MARGIN_MEDIUM_3))
                .foregroundColor(.white)
                .fontWeight(.medium)
            
            // Cinema Facility list
            CinemaFacilitiesListView(textColor: Color(PRIMARY_COLOR), primaryOrNot: true)
                .padding(.top, MARGIN_MEDIUM_2)
            
            FacilityItemView(image: TICKET_CANCEL_GREEN_IMG, text: TICKET_CANCELING_TEXT, textColor: Color(PRIMARY_COLOR))
                .padding(.top, MARGIN_MEDIUM_2)
            
        }
        .padding([.leading,.trailing], MARGIN_MEDIUM_2)
        .padding(.top, MARGIN_XLARGE)
    }
}
