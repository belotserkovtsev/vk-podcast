//
//  PodcastCreatedView.swift
//  vk-podcast
//
//  Created by milkyway on 17.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import SwiftUI

struct PodcastCreatedView: View {
    
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            
            Image("done")
                .padding(.bottom, 16)
            
            Text("Подкаст добавлен")
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 8)
            
            Text("Расскажите своим подписчикам о новом подкасте, чтобы получить больше слушателей")
                .foregroundColor(Color("sublineTextGray"))
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.center)
                .frame(width: 311, height: 60, alignment: .center)
                .padding(.bottom, 24)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("buttonBlue"))
                 
                 Text("Поделиться подкастом")
                       .font(.system(size: 15, weight: .medium))
                       .foregroundColor(.white)
            }
                .frame(width: 203, height: 36)
                .padding(.bottom, 262)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct PodcastCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastCreatedView()
    }
}
