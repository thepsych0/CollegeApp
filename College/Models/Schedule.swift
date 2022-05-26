typealias StudentSchedule = [Weekday: [Slot: Subject]]

extension StudentSchedule {
    func subjectsArray(for weekday: Weekday) -> [(slot: Slot, subject: Subject)]? {
        guard let daySchedule = self[weekday] else {
            return nil
        }
        return daySchedule
            .map { (slot: $0.key, subject: $0.value) }
            .sorted(by: { $0.slot.rawValue < $1.slot.rawValue })
    }
}

enum Slot: Int {
    case slot1
    case slot2
    case slot3
    case slot4
    case slot5
    case slot6

    var startTime: String {
        switch self {
        case .slot1:
            return "9:00"
        case .slot2:
            return "10:30"
        case .slot3:
            return "12:30"
        case .slot4:
            return "14:00"
        case .slot5:
            return "15:30"
        case .slot6:
            return "17:00"
        }
    }
}

typealias TeacherSchedule = [Weekday: [Slot: Group]]

extension TeacherSchedule {
    func groupsArray(for weekday: Weekday) -> [(slot: Slot, group: Group)]? {
        guard let daySchedule = self[weekday] else {
            return nil
        }
        return daySchedule
            .map { (slot: $0.key, group: $0.value) }
            .sorted(by: { $0.slot.rawValue < $1.slot.rawValue })
    }
}
