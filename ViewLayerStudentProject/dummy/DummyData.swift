//
//  DummyData.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/4.
//

import Foundation

let dummyDateData = [
    DateVO(date: Date.now, isSelected: true),
    DateVO(date: Date.now.addingTimeInterval(86400), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*2), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*3), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*4), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*5), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*6), isSelected: false),
    
    DateVO(date: Date.now.addingTimeInterval(86400*7), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*8), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*9), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*10), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*11), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*12), isSelected: false),
    DateVO(date: Date.now.addingTimeInterval(86400*13), isSelected: false)

]

let movieSectionData = [
    MovieSectionVO(id: 1, sectionName: NOW_PLAYING_MOVIE, isSelected: true),
    MovieSectionVO(id: 2, sectionName: COMING_SOON_MOVIE, isSelected: false)
]

// Movie Info List
//let dummyMovieInfo = [
//    MovieInfoVO(id: 1, movieName: "Black Widow", rating: "7.1", releaseDate: "May 8th, 2022", duration: "2hr 15min", castName: "Katty", moviePoster: "blackwidow", genre: ["Action","Adventure","Drama","Animation"], castImage: "blackwidow"),
//
//]

// Snack Type data
//let snackFilterType = [
//    SnackTypeVO(id: 1, snackType: "All", isSelected: true),
//    SnackTypeVO(id: 2, snackType: "Combo", isSelected: false),
//    SnackTypeVO(id: 3, snackType: "Snack", isSelected: false),
//    SnackTypeVO(id: 4, snackType: "Pop Corn", isSelected: false),
//    SnackTypeVO(id: 5, snackType: "Beverage", isSelected: false)
//]

// Payment Type data
//let paymentTypeData = [
//    PaymentTypeVO(id: 1, paymentType: "UPI", image: UPI_IMAGE, isSelected: false),
//    PaymentTypeVO(id: 2, paymentType: "Gift Voucher", image: GIFT_VOUCHER_IMG, isSelected: false),
//    PaymentTypeVO(id: 3, paymentType: "Quick Pay", image: QUICK_PAY_IMG, isSelected: false),
//    PaymentTypeVO(id: 4, paymentType: "Credit Card / Debit Card", image: CREDIT_CARD_IMG, isSelected: false),
//    PaymentTypeVO(id: 5, paymentType: "Redeem Point", image: REDEEM_POINT_IMG, isSelected: false),
//    PaymentTypeVO(id: 6, paymentType: "Mobile Wallet", image: MOBILE_WALLET_IMG, isSelected: false),
//    PaymentTypeVO(id: 7, paymentType: "Net Banking", image: NET_BANKING_IMG, isSelected: false),
//]

// profile setting
let profileSettingData = [
    ProfileSettingVO(id: 1, profileText: "Purchase History", image: IC_HISTORY_IMAGE, isSelected: false),
    ProfileSettingVO(id: 2, profileText: "Offer", image: IC_HISTORY_IMAGE, isSelected: false),
    ProfileSettingVO(id: 3, profileText: "Gift Card", image: IC_GIFT_CARD, isSelected: false),
    ProfileSettingVO(id: 4, profileText: "Location", image: IC_LOCATION_IMG, isSelected: false),
    ProfileSettingVO(id: 5, profileText: "Payment", image: IC_PAYMENT_CARD_IMAGE, isSelected: false),
    ProfileSettingVO(id: 6, profileText: "Help and Support", image: IC_HELP_SUPPORT_IMG, isSelected: false),
    ProfileSettingVO(id: 7, profileText: "Logout", image: IC_LOGOUT_IMAGE, isSelected: false),
]

//let cinemaSeatData = [
//    TimeSlotVO(id: 1, time: "9:30 AM", viewType: "3D", screen: "Screen1", availableCount: 21, bgColor: TIME_COLOR_GRAY, borderColor: SUB_TEXT_COLOR, isSelected: false),
//    TimeSlotVO(id: 2, time: "12:30 AM", viewType: "3D IMAX", screen: "Screen1", availableCount: 30, bgColor: TIME_COLOR_GREEN, borderColor: GREEN_LIGHT_COLOR, isSelected: false),
//    TimeSlotVO(id: 3, time: "12:30 AM", viewType: "3D", screen: "Screen2", availableCount: 2, bgColor: TIME_COLOR_PINK, borderColor: PINK_COLOR, isSelected: false),
//    TimeSlotVO(id: 4, time: "3:30 AM", viewType: "3D", screen: "Screen2", availableCount: 31, bgColor: TIME_COLOR_GREEN, borderColor: GREEN_LIGHT_COLOR, isSelected: false),
//    TimeSlotVO(id: 5, time: "6:30 AM", viewType: "3D DBOX", screen: "Screen2", availableCount: 21, bgColor: TIME_COLOR_ORANGE, borderColor: NEW_ORANGE_COLOR, isSelected: false),
//]

let dummySeats = [
    MovieSeatsVO(text: "A", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "A", type: SEAT_TYPE_TEXT),
    
    MovieSeatsVO(text: "B", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "B", type: SEAT_TYPE_TEXT),
    
    MovieSeatsVO(text: "C", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "C", type: SEAT_TYPE_TEXT),
    
    MovieSeatsVO(text: "D", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "D", type: SEAT_TYPE_TEXT),
    
    MovieSeatsVO(text: "E", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "E", type: SEAT_TYPE_TEXT),
    
    MovieSeatsVO(text: "F", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "F", type: SEAT_TYPE_TEXT),
    
    MovieSeatsVO(text: "G", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "G", type: SEAT_TYPE_TEXT),
    
    MovieSeatsVO(text: "H", type: SEAT_TYPE_TEXT),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_SPACE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_AVAILABLE),
    MovieSeatsVO(text: "H", type: SEAT_TYPE_TEXT),
]

let dropDownData = [
    DropdownItemVO(id: 1, title: "Messages", onSelect: {}),
    DropdownItemVO(id: 2, title: "Archived", onSelect: {}),
    DropdownItemVO(id: 3, title: "Trash", onSelect: {}),
]
// drop down wrap value
let dummyDropDownInfo = [
    
    FilterDataVO(id: 1, title: "Genres", value: dropDownData),
    FilterDataVO(id: 2, title: "Format", value: dropDownData),
    FilterDataVO(id: 3, title: "Month", value: dropDownData)
    
]

let dummySafety = ["Thermanal Scanning", "Contactless Security Check", "Santization Before Every Show", "Disposable 30 glass", "Contactless Food Service", "Package Food", "Deep Cleaning of rest room"]
