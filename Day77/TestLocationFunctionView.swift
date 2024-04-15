import SwiftUI
import CoreLocation
import MapKit
import CoreLocationUI


struct TestLocationFunctionView: View {
    
    let locationFetcher = LocationFetcher()

    var body: some View {
        VStack {
            Button("Start Tracking Location") {
                print("Start Tracking Location")
                locationFetcher.start()
            }

            Button("Read Location") {
                if let location = locationFetcher.lastKnownLocation {
                    print("Your location is \(location)")
                } else {
                    print("Your location is unknown")
                }
            }
        }
    }
}

#Preview {
    TestLocationFunctionView()
}
