//
//  LandmarkList.swift
//  BBSwiftUI_Pro
//
//  Created by Berry on 2020/2/10.
//  Copyright © 2020 BerryBeans. All rights reserved.
//

import SwiftUI

struct LandmarkList<DetailView: View>: View {
    
    @EnvironmentObject private var userData: UserData
    
    let detailViewProducer: (Landmark) -> DetailView
    
    var body: some View {
        List {
            Toggle(isOn: $userData.showFavoritesOnly) {
                Text("Show Favorites Only")
            }
            
            ForEach(userData.landmarks) { landmark in
                if !self.userData.showFavoritesOnly || landmark.isFavorite {
                    NavigationLink(destination: self.detailViewProducer(landmark).environmentObject(self.userData)) {
                        LandmarkRow(landmark: landmark)
                        
                    }
                }
                
            }
        }
            
        .navigationBarTitle(Text("Landmarks"))
    }
}

#if os(watchOS)
typealias PreviewDetailView = WatchLandmarkDetail
#else
typealias PreviewDetailView = LandmarkDetail
#endif


struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList { PreviewDetailView(landmark: $0) }
            .environmentObject(UserData())
    }
}


//struct LandmarkList_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(["iPhone XS Max"], id: \.self) { deviceName in
//            LandmarkList()
//            .environmentObject(UserData())
//            .previewDevice(PreviewDevice(rawValue: deviceName))
//            .previewDisplayName(deviceName)
//        }
//    }
//}
