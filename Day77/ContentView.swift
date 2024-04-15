/*
 Use PhotosPicker to let users import a photo from their photo library.
 Detect when a new photo is imported, and immediately ask the user to name the photo.
 Save that name and photo somewhere safe.
 Show all names and photos in a list, sorted by name.
 Create a detail screen that shows a picture full size.
 Decide on a way to save all this data.
*/

import CoreImage
import PhotosUI
import SwiftUI
import SwiftData




struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
        
    @Query(sort: \LabeledImage.name) var people: [LabeledImage]
    
    @State private var selectedImage: Data?

    @State private var selectedItem: PhotosPickerItem?
    
    @State private var faceName: String = ""
    
    @State private var showingAlert = false
    
    @State private var location: CLLocationCoordinate2D?
    
    let locationFetcher = LocationFetcher()
        
    func addPerson(){
        guard let selectedImage else {return}
        location = locationFetcher.lastKnownLocation
        modelContext.insert(LabeledImage(faceData: selectedImage, name: faceName, location: location))
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(people, id: \.name){ person in
                    
                    NavigationLink{
                       DetailView(person: person)
                    }label:{
                        HStack{
                            person.faceImage
                                .resizable()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                .scaledToFill()
                                .padding()
                            
                            Text(person.name)
                            Spacer()
                        }
                    }
                }
            }
            VStack{
                PhotosPicker(selection: $selectedItem) {
                    ContentUnavailableView("Add face", systemImage: "photo.badge.plus", description: Text("Import another photo"))
                }
                .onChange(of: selectedItem) {
                    Task {
                        selectedImage = try await selectedItem?.loadTransferable(type: Data.self)
                        showingAlert.toggle()
                    }
                }
            }
            .frame(height: 75)
            .alert("Enter face name", isPresented: $showingAlert) {
                TextField("Enter face name", text: $faceName)
                Button("OK", action: addPerson)
            } message: {
                Text("Xcode will print whatever you type.")
            }
        }
        .onAppear(){
            locationFetcher.start()
        }
    }
}

#Preview {
    ContentView()
}
