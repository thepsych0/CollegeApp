import RealmSwift

final class HomeworkObject: Object {
    @objc dynamic var groupNumber = 0

    @objc dynamic private var subjectTypeRawValue = ""
    var subjectType: Subject.SubjectType {
        return .init(rawValue: subjectTypeRawValue)!
    }

    @objc dynamic private(set) var dateString = ""
    var date: Date {
        return DateFormatter.standardDay.date(from: dateString)!
    }

    @objc dynamic private(set) var slotRawValue = 0
    var slot: Slot {
        return Slot(rawValue: slotRawValue)!
    }

    @objc dynamic var text: String = ""

    override init() {}

    init(group: Group, subjectType: Subject.SubjectType, date: Date, slot: Slot) {
        self.groupNumber = group.number
        self.subjectTypeRawValue = subjectType.rawValue
        self.dateString = DateFormatter.standardDay.string(from: date)
        self.slotRawValue = slot.rawValue
    }

}
