import Foundation

final class ServerMock {
    static func authorizeStudent(login: String, password: String) -> Result<Student, ServerError> {
        let credentials = Credentials(login: login, password: password)
        guard let student = ServerDatabaseMock.students[credentials] else {
            return .failure(.wrongCredentials)
        }

        return .success(student)
    }

    static func authorizeTeacher(login: String, password: String) -> Result<Student, ServerError> {
        let credentials = Credentials(login: login, password: password)
        guard let student = ServerDatabaseMock.students[credentials] else {
            return .failure(.wrongCredentials)
        }

        return .success(student)
    }

    static func getWeeks() -> [Week] {
        let earliestDate = DateFormatter.standardDay.date(from: "01.01.2022")!
        let latestDate = DateFormatter.standardDay.date(from: "30.06.2022")!
        var monday = earliestDate.next(.monday, considerToday: true)
        var weeks = [Week]()
        while true {
            weeks.append(Week(startDate: monday))
            let nextMonday = monday.next(.monday)
            guard nextMonday < latestDate else {
                break
            }
            monday = nextMonday
        }
        return weeks
    }
}

fileprivate struct ServerDatabaseMock {
    static let students: [Credentials: Student] = [
        .init(login: "student1", password: "pass1"): .init(
            fullName: "Иван Иванов",
            group: "121",
            gender: .male
        )
    ]
}

enum ServerError: Error {
    case wrongCredentials
}

fileprivate struct Credentials: Equatable, Hashable {
    let login: String
    let password: String

    static func == (lhs: Credentials, rhs: Credentials) -> Bool {
        return lhs.login == rhs.login && lhs.password == rhs.password
    }
}
