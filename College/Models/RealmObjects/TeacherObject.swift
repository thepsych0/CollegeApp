import RealmSwift

typealias Teacher = TeacherObject

final class TeacherObject: Object {
    @objc dynamic var login = ""
    @objc dynamic var fullName = ""
    @objc private dynamic var groupNumbersString = ""
    var groupNumbers: [Int] {
        groupNumbersString.components(separatedBy: ", ").compactMap { Int($0) }
    }
    @objc private dynamic var subjectTypeString = Subject.SubjectType.pe.rawValue
    var subjectType: Subject.SubjectType {
        .init(rawValue: subjectTypeString)!
    }

    override init() {}

    init(login: String, fullName: String, groupNumbers: [Int], subjectType: Subject.SubjectType) {
        self.login = login
        self.fullName = fullName
        self.groupNumbersString = groupNumbers.map { String($0) }.joined(separator: ", ")
        self.subjectTypeString = subjectType.rawValue
    }
}

extension Teacher {
    static var current: Teacher?
}
