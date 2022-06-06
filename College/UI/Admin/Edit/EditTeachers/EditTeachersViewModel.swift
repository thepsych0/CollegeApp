import SwiftUI
import Combine
import RealmSwift

@MainActor class EditTeachersViewModel: ObservableObject {
    @Published var teachers: [Teacher] = []

    init() {
        realm = try! Realm()
        getTeachers()
    }

    var createTeacherView: AnyView {
        let viewModel = TeacherInfoViewModel()
        return AnyView(TeacherInfoScreen(viewModel: viewModel))
    }

    func update() {
        getTeachers()
    }

    func removeTeacher(at offsets: IndexSet) {
        let teachersToDelete = offsets.map { teachers[$0] }
        try! realm.write {
            teachersToDelete.forEach {
                realm.delete($0)
            }
        }
        getTeachers()
    }

    private func getTeachers() {
        teachers = ServerDatabaseMock.Teachers.getAll().sorted(by: { $0.fullName < $1.fullName })
    }

    private var realm: Realm
}
