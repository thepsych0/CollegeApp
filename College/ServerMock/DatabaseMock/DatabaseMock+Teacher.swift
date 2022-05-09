extension ServerDatabaseMock {
    enum Teachers {
        private static let teachers: [Credentials: Teacher] = [
            .init(login: "teacher1", password: "pass1"): .init(
                fullName: "Преподователь Криптоэкономики",
                groups: [
                    ServerDatabaseMock.Groups.get(by: 1)!,
                    ServerDatabaseMock.Groups.get(by: 2)!,
                    ServerDatabaseMock.Groups.get(by: 3)!,
                ],
                subjectType: .cryptoeconomics
            ),
            .init(login: "teacher2", password: "pass2"): .init(
                fullName: "Преподаватель Экономики",
                groups: [
                    ServerDatabaseMock.Groups.get(by: 1)!,
                    ServerDatabaseMock.Groups.get(by: 2)!,
                    ServerDatabaseMock.Groups.get(by: 3)!,
                ],
                subjectType: .economics
            ),
            .init(login: "teacher3", password: "pass3"): .init(
                fullName: "Преподаватель Проектной деятельности",
                groups: [
                    ServerDatabaseMock.Groups.get(by: 1)!,
                    ServerDatabaseMock.Groups.get(by: 2)!,
                    ServerDatabaseMock.Groups.get(by: 3)!,
                ],
                subjectType: .project
            ),
            .init(login: "teacher4", password: "pass4"): .init(
                fullName: "Преподаватель Теории вероятности",
                groups: [
                    ServerDatabaseMock.Groups.get(by: 1)!,
                    ServerDatabaseMock.Groups.get(by: 2)!,
                    ServerDatabaseMock.Groups.get(by: 3)!,
                ],
                subjectType: .probabilityTheory
            ),
            .init(login: "teacher5", password: "pass5"): .init(
                fullName: "Преподаватель Сайтостроения",
                groups: [
                    ServerDatabaseMock.Groups.get(by: 1)!,
                    ServerDatabaseMock.Groups.get(by: 2)!,
                    ServerDatabaseMock.Groups.get(by: 3)!,
                ],
                subjectType: .sitebuilding
            ),
            .init(login: "teacher6", password: "pass6"): .init(
                fullName: "Преподаватель Блокчейн технологий",
                groups: [
                    ServerDatabaseMock.Groups.get(by: 1)!,
                    ServerDatabaseMock.Groups.get(by: 2)!,
                    ServerDatabaseMock.Groups.get(by: 3)!,
                ],
                subjectType: .blockchain
            ),
            .init(login: "teacher7", password: "pass7"): .init(
                fullName: "Преподаватель Физической культуры",
                groups: [
                    ServerDatabaseMock.Groups.get(by: 1)!,
                    ServerDatabaseMock.Groups.get(by: 2)!,
                    ServerDatabaseMock.Groups.get(by: 3)!,
                ],
                subjectType: .pe
            ),
        ]

        static func get(by credentials: Credentials) -> Teacher? {
            teachers.first(where: { $0.key == credentials })?.value
        }

        static func get(by login: String) -> Teacher? {
            teachers.first(where: { $0.key.login == login })?.value
        }
    }
}
