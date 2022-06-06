import RealmSwift

typealias Student = StudentObject

final class StudentObject: Object {
    @objc dynamic var login = ""
    @objc dynamic var fullName = ""
    @objc dynamic var groupNumber = 0
    @objc dynamic private var genderString = Gender.male.rawValue
    var gender: Gender {
        .init(rawValue: genderString)!
    }

    override init() {}

    init(login: String, fullName: String, groupNumber: Int, gender: Gender) {
        self.login = login
        self.fullName = fullName
        self.groupNumber = groupNumber
        self.genderString = gender.rawValue
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object, let otherStudent = object as? StudentObject else {
            return false
        }
        return login == otherStudent.login
    }
}

extension Student {
    static var current: Student?
}
