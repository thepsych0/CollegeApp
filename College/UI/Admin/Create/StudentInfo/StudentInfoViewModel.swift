import SwiftUI
import Combine
import RealmSwift

@MainActor class StudentInfoViewModel: ObservableObject {
    @Published var login = ""
    @Published var password = ""
    @Published var passwordRepeated = ""
    @Published var fullName = ""
    @Published var genderRawValue = Gender.male.rawValue
    @Published var groupNumber = ""

    @Published var availableGroups: [String]

    init() {
        realm = try! Realm()
        availableGroups = ServerDatabaseMock.Groups.all().map { String($0.number) }
    }

    func save() -> String? {
        guard !login.isEmpty,
              !password.isEmpty,
              !passwordRepeated.isEmpty,
              !fullName.isEmpty,
              !genderRawValue.isEmpty,
              !groupNumber.isEmpty else {
            return "Все поля должны быть заполнены"
        }

        guard let groupNumber = Int(groupNumber) else {
            return "Указан неверный номер группы"
        }

        guard let gender = Gender(rawValue: genderRawValue) else {
            return "Указан неверный пол"
        }

        let students = ServerDatabaseMock.Students.getAll()

        guard !students.contains(where: { $0.login == login }) else {
            return "Пользователь с указанным логином уже существует"
        }

        guard password == passwordRepeated else {
            return "Пароли не совпадают"
        }

        let student = Student(
            login: login,
            fullName: fullName,
            groupNumber: groupNumber,
            gender: gender
        )

        let credentials = Credentials(
            login: login,
            password: password
        )

        try! realm.write {
            realm.add(student)
            realm.add(credentials)
        }

        return nil
    }

    private var realm: Realm
}
