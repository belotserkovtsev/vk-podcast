//
//  VkButtonView.swift
//  vk-podcast
//
//  Created by milkyway on 16.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import SwiftUI

struct VkButtonView<Location>: View where Location: View{
    var text: String
    var location: Location
    var navTitle: String
    
    var isActive: Bool
    
    init(with text: String, navTitle nav: String, at loc: Location, isActive: Bool) {
        self.text = text
        self.location = loc
        self.navTitle = nav
        self.isActive = isActive
    }
    
//    @State var isActive = true
    
    var body: some View {
        ZStack {
            if self.isActive {
                NavigationLink(destination: location
                    .navigationBarTitle(Text(navTitle), displayMode: .inline)) {
                    RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("buttonBlue"))
                }
            } else {
                RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("buttonBlue"))
                    .opacity(0.4)
            }
             
             Text(text)
                   .font(.system(size: 15, weight: .medium))
                   .foregroundColor(.white)
        }
    }
}
