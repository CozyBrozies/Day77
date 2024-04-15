//
//  DetailView.swift
//  Day77
//
//  Created by Isaac Herskowitz on 4/15/24.
//

import SwiftUI



struct DetailView: View {
    
    var person: LabeledImage
    
    var body: some View {
        NavigationStack{
            VStack{
                person.faceImage
                    .resizable()
                    .scaledToFit()
                Text(person.name)
            }
            
        }
    }
}

//#Preview {
//    DetailView(person: LabeledImage)
//}
