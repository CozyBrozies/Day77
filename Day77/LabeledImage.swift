//
//  LabeledImage.swift
//  Day77
//
//  Created by Isaac Herskowitz on 4/14/24.
//

import Foundation
import PhotosUI
import SwiftUI

class LabeledImage{
    
    var face: Image
    var name: String
    
    init(face: Image, name: String) {
        self.face = face
        self.name = name
    }
    
}
