////
////  DropDownFilterWrapView.swift
////  ViewLayerStudentProject
////
////  Created by 梁世仪 on 2023/5/18.
////
//
//import SwiftUI
//
//struct DropDownFilterWrapView: View {
//
//    let filterList: [FilterDataVO] = dummyDropDownInfo

//    var body: some View {
//        ZStack {
//            GeometryReader { geo in
//                self.generateFilterContent(in: geo)
//            }
//        }
//    }
//    private func generateFilterContent(in g: GeometryProxy) -> some View {
//        var width = CGFloat.zero
//        var height = CGFloat.zero
//
//        return ZStack(alignment: .topLeading) {
//            ForEach(filterList){ filter in
////                Text(filterList[i])
////                    .foregroundColor(.black)
////                    .font(.system(size: MARGIN_CARD_MEDIUM_2))
////                    .padding([.leading, .trailing], MARGIN_MEDIUM)
////                    .padding([.top,.bottom], MARGIN_SMALL)
////                    .background(Color(PRIMARY_COLOR))
////                    .cornerRadius(MARGIN_SMALL)
////                    .padding([.top,.trailing], MARGIN_MEDIUM)
//                item(for: filter.title)
//                    .alignmentGuide(.leading) { contentSize in
//                        if(abs(width - contentSize.width) > g.size.width) {
//                            width = 0
//                            height -= contentSize.height
//                        }
//                        let result = width
//                        if filter == filterList.last! {
//                            width = 0
//                        } else {
//                            width -= contentSize.width
//                        }
//                        return result
//                    }
//                    .alignmentGuide(.top) { ctSize in
//                        let result = height
//                        if filter == filterList.last! {
//                            height = 0
//                        }
//                        return result
//                    }
//            }
//        }
//
//    }
//    func item(for text: String) -> some View {
//        HStack {
//            Text(text)
//                .foregroundColor(.black)
//                .font(.system(size: MARGIN_CARD_MEDIUM_2))
//
//            Image(systemName: IC_CHEV_DOWN)
//                .resizable()
//                .frame(width: MARGIN_MEDIUM_1, height: MARGIN_SMALL + 2)
//                .font(.system(size: MARGIN_MEDIUM_2))
//                .fontWeight(.bold)
////                .padding(.leading, isSelecting ? 0 : MARGIN_SMALL)
////                .padding(.trailing, isSelecting ? MARGIN_SMALL : 0)
//                .clipped()
////                .rotationEffect(.degrees(isSelecting ? -180 : 0))
//
//        }
//        .padding([.leading, .trailing], MARGIN_MEDIUM)
//        .padding([.top, .bottom], MARGIN_SMALL)
//        .background(Color(PRIMARY_COLOR))
//        .cornerRadius(MARGIN_MEDIUM)
//    }
//}
//
//struct DropDownFilterWrapView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDownFilterWrapView()
//    }
//}
