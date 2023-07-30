//
//  BannerStoreRepo.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/4.
//

import Foundation
import SwiftUI

class BannerStoreRepo: ObservableObject {
    
    var banners: [BannerItemVO]
    let colors: [Color] = [.red, .orange, .yellow, .green, .purple, .pink]
    
    init() {
        banners = []
        for i in 0...4 {
            let newBanner = BannerItemVO(id: i, title: "Banner\(i)", color: colors[i])
            banners.append(newBanner)
        }
    }
}
