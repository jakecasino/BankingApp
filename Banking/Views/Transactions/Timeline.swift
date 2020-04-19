//
//  Timeline.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Foundation
// import Combine

enum TimelineEventTypes {
    case payday
    case billPaid
    case transaction
    case transactionGroup
    case achievement
}

struct TimelineEvent {
	let eventID: UUID
    let date: Date
    let type: TimelineEventTypes
    let transaction: Transaction?
}

class Timeline: ObservableObject {
    @Published var events = [TimelineEvent]()
    
    enum TimelineEventTimeGroups {
        case today
        case yesterday
        case thisWeek
        case lastWeek
        case thisMonth
        case lastMonth
    }
    
    func getEventsFor(_ timeGroup: TimelineEventTimeGroups) -> [TimelineEvent] {
        var events = [TimelineEvent]()
        
        let calendar = Calendar.current
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        
        func endOfDay(for date: Date) -> Date? {
            return calendar.date(byAdding: DateComponents(day: 1), to: startOfToday)
        }
        
        func getTimelineEvents(between startDate: Date, and endDate: Date) {
            self.events.forEach { (event) in
                if (event.date >= startDate)
                    && (event.date < endDate) {
                    events.append(event)
                }
            }
        }
        
        // Today & Yesterday
        guard let endOfToday = endOfDay(for: startOfToday) else { return events }
        guard let startOfYesterday = calendar.date(byAdding: DateComponents(day: -1), to: startOfToday) else { return events }
        
        // This Week & Last Week
        let currentWeekdayNumber = calendar.component(.weekday, from: startOfToday)
        guard let startOfThisWeekDate = calendar.date(byAdding: DateComponents(day: -currentWeekdayNumber + 1), to: startOfToday)
            else { return events}
        guard let startOfLastWeekDate = calendar.date(byAdding: DateComponents(day: +1, weekdayOrdinal: -1), to: startOfThisWeekDate) else { return events }
        
        // This Month & Last Month
        guard let startOfThisMonthDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: startOfToday),
                                                                            month: calendar.component(.month, from: startOfToday)))
            else { return events }
        guard let startOfLastMonthDate = calendar.date(byAdding: DateComponents(month: -1), to: startOfThisMonthDate)
            else { return events }
        
        switch timeGroup {
            case .today:
                getTimelineEvents(between: startOfToday, and: endOfToday)
            
            break
            case .yesterday:
                getTimelineEvents(between: startOfYesterday, and: startOfToday)
                
            break
            case .thisWeek:
                getTimelineEvents(between: startOfThisWeekDate, and: startOfYesterday)
                
            break
            case .lastWeek:
                getTimelineEvents(between: startOfLastWeekDate, and: startOfThisWeekDate)
                
            break
            case .thisMonth:
                getTimelineEvents(between: startOfThisMonthDate, and: startOfLastWeekDate)
            break
            case .lastMonth:
                getTimelineEvents(between: startOfLastMonthDate, and: startOfThisMonthDate)
            break
        }
        
        return events
    }
}

