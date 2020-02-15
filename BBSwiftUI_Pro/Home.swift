//
//  Home.swift
//  BBSwiftUI_Pro
//
//  Created by Berry on 2020/2/13.
//  Copyright © 2020 BerryBeans. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    
    @State var showingProfile = false
    @EnvironmentObject var userData: UserData
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarkData, by: {
                $0.category.rawValue
        }
        )

    }
    
    var featured: [Landmark] {
        landmarkData.filter { (landmark) -> Bool in
            landmark.isFeatured
        }
    }
    
    var profileButton: some View {
        Button(action: {
            self.showingProfile.toggle()
        }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        NavigationView {
            List() {
                FeaturedLandmarks(landmarks: featured)
                    
                ForEach(categories.keys.sorted(), id: \.self) {key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
                
//                NavigationLink(destination: LandmarkList { LandmarkDetail(landmark: $0) }) {
//                    Text("See All")
//                }
                NavigationLink(destination: LandmarkList(detailViewProducer: { (landmark) -> LandmarkDetail in

                    return LandmarkDetail(landmark: landmark)
                })) {
                    Text("See All")
                }
//

            }
            .navigationBarTitle("Featured")
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(self.userData)
            }
        }
    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View {
//        landmarks[0].image
//            .resizable()
//            .scaledToFill()
//            .frame(height: 200)
//            .clipped()
//            .listRowInsets(EdgeInsets())
        PageView(features.map { FeatureCard(landmark: $0)})
            .aspectRatio(3/2, contentMode: .fill)
            .listRowInsets(EdgeInsets())
    }
}
struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome().environmentObject(UserData())
        .previewDevice(PreviewDevice(rawValue: "iPhone x"))
        .previewDisplayName("iPhone x")
    }
}
