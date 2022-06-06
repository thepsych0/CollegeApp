import SwiftUI
import Combine

@MainActor class SelectEditingCategoryViewModel: ObservableObject {

    func destination(for userType: UserType) -> AnyView? {
        switch userType {
        case .teacher:
            let viewModel = EditTeachersViewModel()
            let view = EditTeachersScreen(viewModel: viewModel)
            return AnyView(view)
        case .student:
            let viewModel = EditStudentsViewModel()
            let view = EditStudentsScreen(viewModel: viewModel)
            return AnyView(view)
        case .admin:
            return nil
        }
    }
}
