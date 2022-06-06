import Foundation

final class ServerMock {
    static func authorizeStudent(login: String, password: String) -> Result<Student, ServerError> {
        let credentials = Credentials(login: login, password: password)
        guard let student = ServerDatabaseMock.Students.get(by: credentials) else {
            return .failure(.wrongCredentials)
        }

        return .success(student)
    }

    static func authorizeTeacher(login: String, password: String) -> Result<Teacher, ServerError> {
        let credentials = Credentials(login: login, password: password)
        guard let teacher = ServerDatabaseMock.Teachers.get(by: credentials) else {
            return .failure(.wrongCredentials)
        }

        return .success(teacher)
    }

    static func authorizeAdmin(login: String, password: String) -> Result<Void, ServerError> {
        guard login == "admin", password == "admin" else {
            return .failure(.wrongCredentials)
        }

        return .success(())
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

    static func getSchedule(for teacher: Teacher, week: Week) -> TeacherSchedule {
        var schedule = TeacherSchedule()
        Weekday.allCases.forEach { weekday in
            schedule[weekday] = [:]
            getGroups(for: teacher).forEach { group in
                group.schedule.subjectsArray(for: weekday)?
                    .filter { $0.subject.type == teacher.subjectType }
                    .forEach {
                        schedule[weekday]?[$0.slot] = group
                    }
            }
        }
        return schedule
    }

    static func getGroups(for teacher: Teacher) -> [Group] {
        teacher.groupNumbers.compactMap { ServerDatabaseMock.Groups.get(by: $0) }
    }

    static func getSchedule(for student: Student, week: Week) -> StudentSchedule {
        var schedule = StudentSchedule()
        Weekday.allCases.forEach { weekday in
            schedule[weekday] = [:]
            guard let group = ServerDatabaseMock.Groups.get(by: student.groupNumber) else { return }
            group.schedule.subjectsArray(for: weekday)?
                .forEach {
                    schedule[weekday]?[$0.slot] = $0.subject
                }
        }
        return schedule
    }

    static func getWeek(by date: Date) -> Week? {
        let calendar = Calendar.current
        let previousMonday = calendar.date(byAdding: .weekOfYear, value: -1, to: date.next(.monday))
        return getWeeks().first(where: { $0.startDate == previousMonday })
    }
}

final class ServerDatabaseMock {}

enum ServerError: Error {
    case wrongCredentials
}
