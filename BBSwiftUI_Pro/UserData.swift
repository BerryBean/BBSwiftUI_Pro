//
//  UserData.swift
//  BBSwiftUI_Pro
//
//  Created by Berry on 2020/2/12.
//  Copyright © 2020 BerryBeans. All rights reserved.
//

import SwiftUI

import Combine

final class UserData: ObservableObject {
    
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    @Published var profile = Profile.default
    
    
}
