//
//  DropdownItemVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/17.
//

import Foundation

struct DropdownItemVO: Identifiable{
    var id: Int
    var title: String
    var onSelect: () -> Void
}
