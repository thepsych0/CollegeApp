import Foundation

struct Week {
    let startDate: Date
    var endDate: Date {
        return calendar.date(byAdding: .day, value: 6, to: startDate)!
    }
    var state: State {
        let currentDate = Date()
        if currentDate < startDate {
            return .future
        } else if currentDate > endDate {
            return .past
        } else {
            return .current
        }
    }

    func getDate(for weekday: Weekday) -> Date {
        var dayComponent = DateComponents()
        dayComponent.day = weekday.index
        let date = Calendar.current.date(byAdding: dayComponent, to: startDate)
        return date!
    }
}

enum Weekday: Int, CaseIterable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    var name: String {
        switch self {
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        case .sunday:
            return "Воскресенье"
        }
    }

    var index: Int {
        switch self {
        case .sunday:
            return 6
        case .monday, .tuesday, .wednesday, .thursday, .friday, .saturday:
            return rawValue - 1
        }
    }

    static var sorted: [Weekday] {
        return Weekday.allCases.sorted(by: { $0.index < $1.index })
    }
}

extension Week {
    enum State {
        case past
        case current
        case future
    }
}

extension DateFormatter {
    static var standardDay: DateFormatter {
        let dateFormatter = Self()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }
}

extension Date {
    func next(_ weekday: Weekday,
              direction: Calendar.SearchDirection = .forward,
              considerToday: Bool = false) -> Date
    {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(weekday: weekday.rawValue)

        if considerToday &&
            calendar.component(.weekday, from: self) == weekday.rawValue
        {
            return self
        }

        return calendar.nextDate(after: self,
                                 matching: components,
                                 matchingPolicy: .nextTime,
                                 direction: direction)!
    }
}

private let calendar = Calendar.current
