//
//  DateScrollerView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 17.03.2026.
//

import SwiftUI

struct DateScrollerView: View {
    @Binding var selectedDate: Date
    let brandColor = Color(red: 36/255, green: 161/255, blue: 156/255)
    
    
    let days = (-7...7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: Date()) }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(days, id: \.self) { day in
                    VStack(spacing: 8) {
                        Text(day.formatted(.dateTime.weekday(.abbreviated))) // Pzt, Sal..
                            .font(.caption2)
                            .fontWeight(.semibold)
                        
                        Text(day.formatted(.dateTime.day())) // 14, 15..
                            .font(.system(size: 18, weight: .bold))
                    }
                    .frame(width: 45, height: 70)
                    .background(isSameDay(day1: day, day2: selectedDate) ? brandColor : Color.white)
                    .foregroundColor(isSameDay(day1: day, day2: selectedDate) ? .white : .gray)
                    .cornerRadius(12)
                    .onTapGesture {
                        withAnimation {
                            selectedDate = day
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    func isSameDay(day1: Date, day2: Date) -> Bool {
        Calendar.current.isDate(day1, inSameDayAs: day2)
    }
}
