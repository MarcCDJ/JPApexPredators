//
//  PredatorPhoto.swift
//  JP Apex Predators
//
//  Created by Marc Cruz on 7/28/23.
//

import SwiftUI

struct PredatorPhoto: View {
    let predatorImage: String
    
    var body: some View {
        Image(predatorImage)
            .resizable()
            .scaledToFit()
            .shadow(color: .white, radius: 1, x: 0, y: 0)
            .rotation3DEffect(
                .degrees(180),
                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
            )
            .padding(10)
    }
}

struct PredatorPhoto_Previews: PreviewProvider {
    static var previews: some View {
        PredatorPhoto(predatorImage: "velociraptor")
            .preferredColorScheme(.dark)
    }
}
