//
//  Calendar Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/18.
//

import SwiftUI

struct CalendarView: View {
    private var calendar: Calendar {
        return Calendar.current
    }

    @State private var selectedDate: Date = Date()

    var body: some View {
        VStack {
            header
            daysOfWeek
            calendarGrid
        }
        .padding()
    }

    private var header: some View {
        Text("\(calendar.component(.month, from: selectedDate)) \(calendar.component(.year, from: selectedDate))")
            .font(.title)
            .padding(.vertical)
    }

    private var daysOfWeek: some View {
        HStack {
            ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                Text(day)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
        }
    }

    private var calendarGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 8) {
            ForEach(monthDates(), id: \.self) { date in
                Text("\(calendar.component(.day, from: date))")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(isDateSelected(date) ? Color.blue : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture {
                        selectedDate = date
                    }
            }
        }
    }

    private func monthDates() -> [Date] {
        guard let monthRange = calendar.range(of: .day, in: .month, for: selectedDate) else { return [] }
        let monthDays = monthRange.map { day -> Date in
            return calendar.date(bySetting: .day, value: day, of: selectedDate)!
        }
        return monthDays
    }

    private func isDateSelected(_ date: Date) -> Bool {
        return calendar.isDate(date, inSameDayAs: selectedDate)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
