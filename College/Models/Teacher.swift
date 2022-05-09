struct Teacher {
    let fullName: String
    let groups: [Group]
    let subjectType: Subject.SubjectType
}

extension Teacher {
    static var current: Teacher?
}
