//
//  ViewUtilityFunctions.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/14.
//

import Foundation
import SwiftUI

//let SEAT_COLUMNS_COUNT = 18
//let SEAT_SPACING = 7.0
func getGridItems(numberOfColumns: Int, spacing: CGFloat) -> [GridItem] {
    return (1...numberOfColumns).map{ _ in
        GridItem(.flexible(), spacing: spacing)
    }
}

func getGridItems(numberOfColumns: Int) -> [GridItem] {
    return (1...numberOfColumns).map { _ in
        GridItem(.flexible())
    }
}
