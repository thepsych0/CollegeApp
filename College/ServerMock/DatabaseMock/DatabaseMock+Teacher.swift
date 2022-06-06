import RealmSwift

extension ServerDatabaseMock {
    enum Teachers {
        private static let initialTeachers: [Credentials: Teacher] = [
            .init(login: "teacher1", password: "pass1"): .init(
                login: "teacher1",
                fullName: "Преподаватель Криптоэкономики",
                groupNumbers: [1, 2, 3],
                subjectType: .cryptoeconomics
            ),
            .init(login: "teacher2", password: "pass2"): .init(
                login: "teacher2",
                fullName: "Преподаватель Экономики",
                groupNumbers: [1, 2, 3],
                subjectType: .economics
            ),
            .init(login: "teacher3", password: "pass3"): .init(
                login: "teacher3",
                fullName: "Преподаватель Проектной деятельности",
                groupNumbers: [1, 2, 3],
                subjectType: .project
            ),
            .init(login: "teacher4", password: "pass4"): .init(
                login: "teacher4",
                fullName: "Преподаватель Теории вероятности",
                groupNumbers: [1, 2, 3],
                subjectType: .probabilityTheory
            ),
            .init(login: "teacher5", password: "pass5"): .init(
                login: "teacher5",
                fullName: "Преподаватель Сайтостроения",
                groupNumbers: [1, 2, 3],
                subjectType: .sitebuilding
            ),
            .init(login: "teacher6", password: "pass6"): .init(
                login: "teacher6",
                fullName: "Преподаватель Блокчейн технологий",
                groupNumbers: [1, 2, 3],
                subjectType: .blockchain
            ),
            .init(login: "teacher7", password: "pass7"): .init(
                login: "teacher7",
                fullName: "Преподаватель Физической культуры",
                groupNumbers: [1, 2, 3],
                subjectType: .pe
            ),
        ]

        static func injectInitialTeachers() {
            let realm = try! Realm()

            initialTeachers.forEach { element in
                try! realm.write {
                    realm.add(element.key)
                    realm.add(element.value)
                }
            }
        }

        static func get(by credentials: Credentials) -> Teacher? {
            let realm = try! Realm()

            guard !realm.objects(CredentialsObject.self).where({
                $0.login == credentials.login && $0.password == credentials.password
            }).isEmpty else {
                return nil
            }

            return realm.objects(TeacherObject.self).where({ $0.login == credentials.login }).first
        }

        static func getAll() -> [Teacher] {
            let realm = try! Realm()

            return Array(realm.objects(TeacherObject.self))
        }
    }
}
