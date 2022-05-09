import SwiftUI
import Combine
import RealmSwift

@MainActor class SubjectActivityViewModel: ObservableObject {
    @Published var group: Group
    @Published var students: [Student]

    @Published var date: Date
    @Published var slot: Slot

    @Published var activityDict: [Student: SubjectActivityObject] = [:]

    @Published var homeworkText: String = ""
    @Published private var homework: HomeworkObject?

    @Published var week: Week?

    init(group: Group, date: Date, slot: Slot) {
        self.group = group
        self.date = date
        self.slot = slot
        self.students = ServerDatabaseMock.Students.get(by: group.number).sorted(by: { $0.fullName < $1.fullName })
        updateActivities()
        updateHomework()
        $homework
            .sink { [weak self] newValue in
                guard let homework = newValue else { return }
                self?.homeworkText = homework.text
            }
            .store(in: &disposeBag)
        $date
            .sink { [weak self] newValue in
                self?.week = ServerMock.getWeek(by: newValue)
            }
            .store(in: &disposeBag)
    }

    func setStudentPresence(_ wasPresent: Bool, for student: Student) {
        if let activity = activityDict[student] {
            try! realm.write {
                activity.setStudentPresence(wasPresent)
                updateActivities()
            }
        } else {
            guard let teacher = Teacher.current else { return }
            let activity = SubjectActivityObject(
                student: student,
                subjectType: teacher.subjectType,
                date: date,
                slot: slot
            )
            activity.setStudentPresence(wasPresent)
            try! realm.write {
                realm.add(activity)
                updateActivities()
            }
        }
    }

    func setStudentMark(_ mark: Int, for student: Student) {
        if let activity = activityDict[student] {
            try! realm.write {
                activity.setStudentMark(mark)
                updateActivities()
            }
        } else {
            guard let teacher = Teacher.current else { return }
            let activity = SubjectActivityObject(
                student: student,
                subjectType: teacher.subjectType,
                date: date,
                slot: slot
            )
            activity.setStudentMark(mark)
            try! realm.write {
                realm.add(activity)
                updateActivities()
            }
        }
    }

    func saveHomework() {
        if let homework = homework {
            try! realm.write {
                homework.text = homeworkText
                updateHomework()
            }
        } else {
            guard let teacher = Teacher.current else { return }
            let homework = HomeworkObject(
                group: group,
                subjectType: teacher.subjectType,
                date: date,
                slot: slot
            )
            homework.text = homeworkText
            try! realm.write {
                realm.add(homework)
                updateHomework()
            }
        }
    }

    private func updateActivities() {
        activityDict = [:]
        let filters: [String: Any] = [
            "groupNumber": group.number,
            "slotRawValue": slot.rawValue,
            "dateString": "'\(DateFormatter.standardDay.string(from: date))'"
        ]
        let activities = realm.objects(SubjectActivityObject.self).filter(
            filters
                .map { "\($0.key) == \($0.value)" }
                .joined(separator: " AND ")
        )
        activities.forEach {
            if let student = ServerDatabaseMock.Students.get(by: $0.studentLogin) {
                activityDict[student] = $0
            }
        }
    }

    private func updateHomework() {
        let filters: [String: Any] = [
            "groupNumber": group.number,
            "slotRawValue": slot.rawValue,
            "dateString": "'\(DateFormatter.standardDay.string(from: date))'"
        ]
        guard let homework = realm.objects(HomeworkObject.self)
            .filter(
                filters
                    .map { "\($0.key) == \($0.value)" }
                    .joined(separator: " AND ")
            )
            .first else { return }
        self.homework = homework
    }

    private let realm = try! Realm()
    private var disposeBag = Set<AnyCancellable>()
}
