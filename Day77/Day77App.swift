//
//  Day77App.swift
//  Day77
//
//  Created by Isaac Herskowitz on 4/13/24.
//

import SwiftUI
import SwiftData

@main
struct Day77App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: LabeledImage.self)
    }
}
