//
//  TabsScreen.swift
//  College
//
//  Created by ThePsych0 on 27.04.2022.
//

import SwiftUI

struct TabsScreen: View {
    var body: some View {
        TabView {
            StudentAccountScreen(viewModel: .init(student: viewModel.student))
                .tabItem {
                    Label("Профиль", systemImage: "list.dash")
                }

            ScheduleScreen()
                .tabItem {
                    Label("Расписание", systemImage: "square.and.pencil")
                }
        }
        .padding()
    }


    init(viewModel: TabsViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: TabsViewModel
}

struct TabsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabsScreen(viewModel: .init(student: Student.testMale))
    }
}
