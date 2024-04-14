/*
 Use PhotosPicker to let users import a photo from their photo library.
 Detect when a new photo is imported, and immediately ask the user to name the photo.
 Save that name and photo somewhere safe.
 
 Show all names and photos in a list, sorted by name.
 
 Create a detail screen that shows a picture full size.
 Decide on a way to save all this data.
*/

import SwiftUI
import PhotosUI


struct ContentView: View {
    
    @State var people: [LabeledImage] = []
    
    @State private var selectedImage: Image?

    @State private var selectedItem: PhotosPickerItem?
    
    @State private var faceName: String = ""
    
    @State private var showingAlert = false
    
    func addPerson(){
        guard let selectedImage else {return}
        people.append(LabeledImage(face: selectedImage, name: faceName))
    }
 
    var body: some View {
        VStack{
            PhotosPicker(selection: $selectedItem) {
                if people.isEmpty {
                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                } else {
                    ContentUnavailableView("Add face", systemImage: "photo.badge.plus", description: Text("Import another photo"))
                }
            }
            .onChange(of: selectedItem) {
                Task {
                    selectedImage = try await selectedItem?.loadTransferable(type: Image.self)
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
        ScrollView{
            ForEach(people, id: \.name){ person in
                VStack{
                    person.face
                        .resizable()
                        .scaledToFit()
                    Text(person.name)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
