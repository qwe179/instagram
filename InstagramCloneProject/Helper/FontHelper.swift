//
//  FontHelper.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/26.
//

import SwiftUI

struct FontHelper {
    static let shared = FontHelper()
    func customFontText(text: String,boldText: String = "",font: String = "NotoSansKR-Thin_Regular" , fontSize: Int) -> some View {
        return Text("\(text) \(Text(boldText).bold())")
            .font(.custom(font, size: CGFloat(fontSize)))
    }
    
    private init(){}
}
