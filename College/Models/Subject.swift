struct Subject: Identifiable {
    var id: String {
        return type.rawValue
    }

    let type: SubjectType
    var activity: Activity?
    var homework: String?

    init(type: SubjectType, activity: Activity? = nil) {
        self.type = type
        self.activity = activity
    }

    enum Activity {
        case present(mark: Int? = nil)
        case absent

        var wasPresent: Bool {
            switch self {
            case .present:
                return true
            case .absent:
                return false
            }
        }

        var mark: Int? {
            switch self {
            case .present(let mark):
                return mark
            case .absent:
                return nil
            }
        }
    }
}

extension Subject {
    enum SubjectType: String {
        case sitebuilding
        case blockchain
        case project
        case economics
        case cryptoeconomics
        case probabilityTheory
        case pe

        var name: String {
            switch self {
            case .sitebuilding:
                return "Сайтостроение"
            case .blockchain:
                return "Технология блокчейн"
            case .project:
                return "Основы проектной деятельности"
            case .economics:
                return "Основы экономики"
            case .cryptoeconomics:
                return "Криптоэкономика"
            case .probabilityTheory:
                return "Теория вероятностей"
            case .pe:
                return "Физическая культура"
            }
        }
    }
}
