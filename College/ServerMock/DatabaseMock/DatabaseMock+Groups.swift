extension ServerDatabaseMock {
    enum Groups {
        private static let groups: [Group] = [
            .init(
                number: 1,
                schedule: [
                    .monday: [
                        .slot1: Subject(type: .cryptoeconomics),
                        .slot2: Subject(type: .pe),
                        .slot3: Subject(type: .probabilityTheory),
                        .slot4: Subject(type: .probabilityTheory),

                    ],
                    .tuesday: [
                        .slot1: Subject(type: .blockchain),
                        .slot2: Subject(type: .sitebuilding),
                        .slot4: Subject(type: .project),
                    ],
                    .thursday: [
                        .slot3: Subject(type: .economics),
                        .slot4: Subject(type: .economics),
                        .slot5: Subject(type: .sitebuilding),
                    ],
                    .wednesday: [
                        .slot1: Subject(type: .cryptoeconomics),
                        .slot2: Subject(type: .project),
                        .slot3: Subject(type: .sitebuilding),
                    ],
                    .friday: [
                        .slot1: Subject(type: .cryptoeconomics),
                        .slot2: Subject(type: .probabilityTheory),
                        .slot3: Subject(type: .sitebuilding),
                        .slot4: Subject(type: .project),
                    ],
                ]
            ),
            .init(
                number: 2,
                schedule: [
                    .monday: [
                        .slot1: Subject(type: .economics),
                        .slot2: Subject(type: .project),
                        .slot3: Subject(type: .probabilityTheory),
                    ],
                    .tuesday: [
                        .slot1: Subject(type: .sitebuilding),
                        .slot2: Subject(type: .pe),
                        .slot3: Subject(type: .project),
                    ],
                    .thursday: [
                        .slot1: Subject(type: .cryptoeconomics),
                        .slot2: Subject(type: .project),
                        .slot3: Subject(type: .sitebuilding),
                        .slot4: Subject(type: .pe),
                    ],
                    .saturday: [
                        .slot3: Subject(type: .cryptoeconomics),
                        .slot4: Subject(type: .blockchain),
                        .slot5: Subject(type: .blockchain),
                    ],
                ]
            ),
            .init(
                number: 3,
                schedule: [
                    .monday: [
                        .slot1: Subject(type: .cryptoeconomics),
                        .slot2: Subject(type: .sitebuilding),
                        .slot3: Subject(type: .blockchain),
                        .slot4: Subject(type: .pe),
                    ],
                    .tuesday: [
                        .slot1: Subject(type: .economics),
                        .slot2: Subject(type: .sitebuilding),
                        .slot3: Subject(type: .project),
                        .slot4: Subject(type: .probabilityTheory),
                    ],
                    .wednesday: [
                        .slot1: Subject(type: .cryptoeconomics),
                        .slot2: Subject(type: .project),
                        .slot3: Subject(type: .probabilityTheory)
                    ],
                    .thursday: [
                        .slot3: Subject(type: .sitebuilding),
                        .slot4: Subject(type: .pe)
                    ],
                    .friday: [
                        .slot1: Subject(type: .cryptoeconomics),
                        .slot2: Subject(type: .project),
                        .slot3: Subject(type: .economics),
                        .slot4: Subject(type: .project),
                    ],
                ]
            )
        ]

        static func get(by number: Int) -> Group? {
            groups.first(where: { $0.number == number })
        }

        static func all() -> [Group] {
            groups
        }
    }
}
