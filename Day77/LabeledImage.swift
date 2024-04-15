//
//  LabeledImage.swift
//  Day77
//
//  Created by Isaac Herskowitz on 4/14/24.
//


import CoreImage
import Foundation
import PhotosUI
import SwiftUI
import SwiftData

import CoreLocation
import MapKit
import CoreLocationUI

@Model
class LabeledImage: Identifiable{
    
//    @Attribute(.externalStorage) 
    var faceData: Data
    
    var faceUIImage: UIImage{
        UIImage(data: faceData)!
    }

    var faceImage: Image{
        Image(uiImage: faceUIImage)
    }
    
    var name: String
    
    var location: CLLocationCoordinate2D?
    
    init(faceData: Data, name: String, location: CLLocationCoordinate2D?) {
        self.faceData = faceData
        self.name = name
        self.location = location!
    }
}
