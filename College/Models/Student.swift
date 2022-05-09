struct Student {
    let login: String
    let fullName: String
    let groupNumber: Int
    let gender: Gender
}

extension Student: Hashable {}

extension Student {
    static var current: Student?
}
