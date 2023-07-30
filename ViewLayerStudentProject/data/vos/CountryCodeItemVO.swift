//
//  CountryCodeItem.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/4.
//

import Foundation

struct CountryCodeItemVO: Identifiable {
    let id: Int
    let title: String
    let onSelect: () -> Void
}
