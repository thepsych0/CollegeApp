import SwiftUI
import Combine
import RealmSwift

@MainActor class TeacherInfoViewModel: ObservableObject {
    @Published var login = ""
    @Published var password = ""
    @Published var passwordRepeated = ""
    @Published var fullName = ""
    @Published var subjectTypeRawValue = ""

    @Published var availableGroups: [String]
    @Published var availableSubjects: [Subject.SubjectType]

    init() {
        realm = try! Realm()
        availableGroups = ServerDatabaseMock.Groups.all().map { String($0.number) }
        availableSubjects = [
            .blockchain,
            .cryptoeconomics,
            .economics,
            .pe,
            .probabilityTheory,
            .project,
            .sitebuilding
        ]
    }

    func save() -> String? {
        guard !login.isEmpty,
              !password.isEmpty,
              !passwordRepeated.isEmpty,
              !fullName.isEmpty,
              !subjectTypeRawValue.isEmpty else {
            return "Все поля должны быть заполнены"
        }

        guard let subjectType = Subject.SubjectType(rawValue: subjectTypeRawValue) else {
            return "Указан неверный предмет"
        }

        let teachers = ServerDatabaseMock.Teachers.getAll()

        guard !teachers.contains(where: { $0.login == login }) else {
            return "Пользователь с указанным логином уже существует"
        }

        guard !teachers.contains(where: { $0.subjectType == subjectType }) else {
            return "У указанных групп уже есть преподаватель предмата \(subjectType.name)"
        }

        guard password == passwordRepeated else {
            return "Пароли не совпадают"
        }

        let student = Teacher(
            login: login,
            fullName: fullName,
            groupNumbers: ServerDatabaseMock.Groups.all().map { $0.number },
            subjectType: subjectType
        )

        try! realm.write {
            realm.add(student)
        }

        return nil
    }

    private var realm: Realm
}
