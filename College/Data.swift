import Foundation

struct Group {
    let number: Int
    let schedule: Schedule
    let students: [Student]
}

enum Gender {
    case male
    case female
}

final class CollegeData {
    static let group: Group = .init(
        number: 1,
        schedule: [
            .monday: [
                .slot1: Subject(type: .physics),
                .slot2: Subject(type: .chemistry, activity: .present(grade: "5")),
                .slot3: Subject(type: .programming, activity: .absent)
            ],
            .tuesday: [
                .slot1: Subject(type: .math),
                .slot2: Subject(type: .chemistry, activity: .present(grade: "4")),
                .slot4: Subject(type: .programming, activity: .absent)
            ],
            .thursday: [
                .slot2: Subject(type: .programming),
                .slot3: Subject(type: .chemistry, activity: .present(grade: "5")),
                .slot4: Subject(type: .literature)
            ],
        ],
        students: [
        ]
    )
}
