//
//  SplashScreenView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import SwiftUI
import AVKit

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
//    private let player = AVPlayer(url: URL(string: "https://www.figma.com/proto/dUsBUG179d1skgTodJbCtZ/Untitled?page-id=0%3A1&type=design&node-id=18-167&viewport=500%2C463%2C0.13&scaling=min-zoom")!)

    var body: some View {
//        VideoPlayer(player: player)
//            .onAppear() {
//                // Start the player going, otherwise controls don't appear
//                player.play()
//            }
//            .onDisappear() {
//                // Stop the player when the view disappears
//                player.pause()
//            }
//    }
        ZStack{
            // Background Color
            Color(BG_COLOR)

            VStack {
                // Logo
                Image(APP_LOGO)
                    .resizable()
                    .frame(width: IMAGE_WIDTH, height: IMAGE_HEIGHT)

                // App Name
                HStack {
                    Text("C")
                        .foregroundColor(Color(PRIMARY_COLOR))
                    Text(APP_LABEL)
                        .foregroundColor(Color(TITLE_LABEL_COLOR))
                }
                .font(.system(size: MARGIN_MEDIUM_4))
            }

        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(2.0)) {
                self.isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView(isActive: $isActive)
        }
    }

}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
