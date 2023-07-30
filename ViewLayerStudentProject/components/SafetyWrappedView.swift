//
//  SafetyWrappedView.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/22.
//

import SwiftUI

struct SafetyWrappedView: View {
    let safetyList: [String] = dummySafety
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                self.generateContent(in: geo)
            }
        }
    }
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            
            ForEach(safetyList, id: \.self) { data in
//                ForEach(movieData.genre, id: \.self){ genre in
                    Text(data)
                        .foregroundColor(.black)
                        .font(.system(size: MARGIN_CARD_MEDIUM_2))
                        .padding([.leading, .trailing], MARGIN_MEDIUM)
                        .padding([.top, .bottom], MARGIN_SMALL)
                        .background(Color(PRIMARY_COLOR))
                        .cornerRadius(MARGIN_MEDIUM_1)
                        .padding([.top, .trailing], MARGIN_MEDIUM)
                        .alignmentGuide(.leading) { showing in
                            if(abs(width - showing.width) > g.size.width) {
                                width = 0
                                height -= showing.height
                            }
                            let result = width
                            if true {
                                width = 0 // last item
                            } else {
                                width -= showing.width
                            }
                            return result
                        }
                        .alignmentGuide(.top, computeValue: { showing in
                            let result = height
                            if true {
                                height = 0 // last item
                            }
                            return result
                        })
//                }
            }
        }
    }
    func item(for text: String) -> some View {
        Text(text)
            .foregroundColor(.black)
            .font(.system(size: MARGIN_CARD_MEDIUM_2))
            .padding([.leading, .trailing], MARGIN_MEDIUM)
            .padding([.top, .bottom], MARGIN_SMALL)
            .background(Color(PRIMARY_COLOR))
            .cornerRadius(MARGIN_MEDIUM_1)
    }
}

struct SafetyWrappedView_Previews: PreviewProvider {
    static var previews: some View {
        SafetyWrappedView()
    }
}
