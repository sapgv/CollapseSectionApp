//
//  Paragraph.swift
//  CollapseSectionApp
//
//  Created by Grigory Sapogov on 03.11.2023.
//

import Foundation

class Paragraph {
    
    var name: String
    var type: Int
    var cellText: String
    var isCollapsed: Bool
    var isHidded: Bool
    
    init(name: String,
         type: Int,
         cellText: String = "",
         isCollapsed: Bool = false,
         isHidden: Bool = false) {
        self.name = name
        self.type = type
        self.cellText = cellText.isEmpty ? "Текст для \(type)" : cellText
        self.isCollapsed = isCollapsed
        self.isHidded = isHidden
    }
    
}
