struct Subject: Identifiable {
    var id: String {
        return type.rawValue
    }

    let type: SubjectType
    let activity: Activity?

    init(type: SubjectType, activity: Activity? = nil) {
        self.type = type
        self.activity = activity
    }

    var grade: String? {
        guard let activity = activity else {
            return nil
        }
        switch activity {
        case .present(let grade):
            return grade
        case .absent:
            return nil
        }
    }

    var wasPresent: Bool {
        guard let activity = activity else {
            return true
        }
        switch activity {
        case .present:
            return true
        case .absent:
            return false
        }
    }

    enum Activity {
        case present(grade: String?)
        case absent
    }
}

extension Subject {
    enum SubjectType: String {
        case math = "Математика"
        case physics = "Физика"
        case chemistry = "Химия"
        case programming = "Программирование"
        case literature = "Литература"
    }
}
