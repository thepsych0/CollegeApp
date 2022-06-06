import SwiftUI
import Combine
import RealmSwift

@MainActor class EditStudentsViewModel: ObservableObject {
    @Published var students: [Student] = []

    init() {
        realm = try! Realm()
        getStudents()
    }

    var createStudentView: AnyView {
        let viewModel = StudentInfoViewModel()
        return AnyView(StudentInfoScreen(viewModel: viewModel))
    }

    func update() {
        getStudents()
    }

    func removeStudent(at offsets: IndexSet) {
        let studentsToDelete = offsets.map { students[$0] }
        try! realm.write {
            studentsToDelete.forEach {
                realm.delete($0)
            }
        }
        getStudents()
    }

    private func getStudents() {
        students = ServerDatabaseMock.Students.getAll().sorted(by: { $0.fullName < $1.fullName })
    }

    private var realm: Realm
}
