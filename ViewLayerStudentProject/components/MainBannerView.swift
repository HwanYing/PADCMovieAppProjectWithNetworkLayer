//
//  MainBannerView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/4.
//

import SwiftUI

struct MainBannerView: View {
    
    @StateObject var bannerStore = BannerStoreRepo()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State var activeIndex: Int = 0
    
    var body: some View {
        ZStack {
            ForEach(bannerStore.banners) { banner in
                
                // Banner View
                ZStack{
                    RoundedRectangle(cornerRadius: MARGIN_MEDIUM_2)
                        .fill(banner.color)
                    Text(banner.title)
                        .padding()
                }
                .frame(width: 300, height: 200)
                .scaleEffect(1.0 - abs(distance(banner.id)) * 0.3)
                .opacity(1.0 - abs(distance(banner.id)) * 0.3)
                .offset(x: myXOffset(banner.id), y: 0)
                .zIndex(1.0 - abs(distance(banner.id)) * 0.1)
            }
            
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    
                    print("Value", value)
                    print("Value translation ", value.translation.width)
                    print("Dragging Item",draggingItem)
                    
                    draggingItem = snappedItem + value.translation.width / 100
                })
                .onEnded({ value in
                    withAnimation {
                        print("Dragging Item", draggingItem)
                        print("Snapped Item", snappedItem)
                        print("Value predict end translation", value.predictedEndTranslation.width)
                        
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(bannerStore.banners.count))
                        snappedItem = draggingItem
                     
                        // get the active item index
                        self.activeIndex = bannerStore.banners.count + Int(draggingItem)
                        if self.activeIndex > bannerStore.banners.count || Int(draggingItem) >= 0 {
                            self.activeIndex = Int(draggingItem)
                            
                        }
                        print(self.activeIndex)
                    }
                })
        )
    }
        func distance(_ banner: Int) -> Double {
            return (draggingItem - Double(banner)).remainder(dividingBy: Double(bannerStore.banners.count))
        }
        func myXOffset(_ banner: Int) -> Double {
            let angle = Double.pi * 2 / Double(bannerStore.banners.count) * distance(banner)
            return sin(angle) * 200
        }
    }


struct MainBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MainBannerView()
    }
}
