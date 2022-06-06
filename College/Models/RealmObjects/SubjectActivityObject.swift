import RealmSwift

final class SubjectActivityObject: Object {
    @objc dynamic var studentLogin = ""

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

    @objc dynamic var groupNumber = 0

    @objc dynamic private var isPresent = true
    @objc dynamic private var mark: Int = -1
    var activity: Subject.Activity? {
        if isPresent {
            if mark >= 0 {
                return .present(mark: mark)
            } else {
                return .present()
            }
        } else {
            return .absent
        }
    }

    override init() {}

    init(student: Student, subjectType: Subject.SubjectType, date: Date, slot: Slot) {
        self.studentLogin = student.login
        self.groupNumber = student.groupNumber
        self.subjectTypeRawValue = subjectType.rawValue
        self.dateString = DateFormatter.standardDay.string(from: date)
        self.slotRawValue = slot.rawValue
    }

    func setStudentPresence(_ wasPresent: Bool) {
        isPresent = wasPresent
    }

    func setStudentMark(_ mark: Int) {
        self.mark = mark
    }
}
