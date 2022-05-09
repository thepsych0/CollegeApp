import SwiftUI

import RealmSwift

@main
struct CollegeApp: SwiftUI.App {

    init() {
        let config = Realm.Configuration(schemaVersion: 5)
        Realm.Configuration.defaultConfiguration = config
    }

    var body: some Scene {
        WindowGroup {
            StartScreen()
        }
    }
}
