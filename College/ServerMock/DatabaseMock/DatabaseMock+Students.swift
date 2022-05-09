extension ServerDatabaseMock {
    enum Students {
        private static let students: [Credentials: Student] = [
            .init(login: "student1", password: "pass1"): .init(
                login: "student1",
                fullName: "Студент Первый",
                groupNumber: 1,
                gender: .male
            ),
            .init(login: "student2", password: "pass2"): .init(
                login: "student2",
                fullName: "Студентка Вторая",
                groupNumber: 1,
                gender: .female
            ),
            .init(login: "student3", password: "pass3"): .init(
                login: "student3",
                fullName: "Студентка Третья",
                groupNumber: 1,
                gender: .female
            ),
            .init(login: "student4", password: "pass4"): .init(
                login: "student4",
                fullName: "Студент Четвертый",
                groupNumber: 1,
                gender: .male
            ),
            .init(login: "student5", password: "pass5"): .init(
                login: "student5",
                fullName: "Студент Пятый",
                groupNumber: 2,
                gender: .male
            ),
            .init(login: "student6", password: "pass6"): .init(
                login: "student6",
                fullName: "Студентка Шестая",
                groupNumber: 2,
                gender: .female
            ),
            .init(login: "student7", password: "pass7"): .init(
                login: "student7",
                fullName: "Студентка Седьмая",
                groupNumber: 2,
                gender: .female
            ),
            .init(login: "student8", password: "pass8"): .init(
                login: "student8",
                fullName: "Студент Восьмой",
                groupNumber: 2,
                gender: .male
            ),
            .init(login: "student9", password: "pass9"): .init(
                login: "student9",
                fullName: "Студент Девятый",
                groupNumber: 3,
                gender: .male
            ),
            .init(login: "student10", password: "pass10"): .init(
                login: "student10",
                fullName: "Студент Десятый",
                groupNumber: 3,
                gender: .male
            ),
            .init(login: "student11", password: "pass11"): .init(
                login: "student11",
                fullName: "Студентка Одиннадцатая",
                groupNumber: 3,
                gender: .female
            ),
            .init(login: "student12", password: "pass12"): .init(
                login: "student12",
                fullName: "Студентка Двенадцатая",
                groupNumber: 3,
                gender: .female
            ),
        ]

        static func get(by credentials: Credentials) -> Student? {
            students.first(where: { $0.key == credentials })?.value
        }

        static func get(by login: String) -> Student? {
            students.first(where: { $0.key.login == login })?.value
        }

        static func get(by groupNumber: Int) -> [Student] {
            students
                .filter { $0.value.groupNumber == groupNumber }
                .map { $0.value }
        }
    }
}
