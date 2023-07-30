//
//  TabBarView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import SwiftUI

struct TabBarView: View {
    
    @State var current: Page = .movies
    @Binding var region: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                Color(BG_COLOR)
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    TabView(selection: $current) {
                        // Main Movie Tab
                        MovieListScreenView(region: $region)
                            .tag(Page.movies)
                        
                        // Cinema Tab
                        TicketView()
                            .tag(Page.cinema)
                        
                        // Ticket Tab
                        TicketView()
                            .tag(Page.ticket)
                        
                        // Profile Tab
                        MyProfileView()
                            .tag(Page.profile)
                    }
                    HStack(spacing: 0.0) {
                        // TabBarItem
                        TabBarItem(current: $current, title: Page.movies, image: IC_TAB_ONE)
                        Spacer(minLength: 0)
                        TabBarItem(current: $current, title: Page.cinema, image: IC_TAB_TWO)
                        Spacer(minLength: 0)
                        TabBarItem(current: $current, title: Page.ticket, image: IC_TAB_THREE)
                        Spacer(minLength: 0)
                        TabBarItem(current: $current, title: Page.profile, image: IC_TAB_FOUR)
                    }
                    .background(Color(BG_COLOR))
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(region: .constant(""))
    }
}
