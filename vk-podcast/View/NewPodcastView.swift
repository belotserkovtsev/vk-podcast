//
//  ContentView.swift
//  vk-podcast
//
//  Created by milkyway on 16.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import SwiftUI

struct NewPodcastView: View {
    @State var post: PodcastPost
    
    var body: some View {
        NavigationView {
            NewPodcastViewContent(post: $post)
                .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct NewPodcastViewContent: View {
    @Binding var post: PodcastPost
    
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            
            Image("plus")
                .padding(.bottom, 16)
            
            Text("Добавьте первый подкаст")
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 8)
            
            Text("Добавляйте, редактируйте и делитесь подкастами вашего сообщества")
                .foregroundColor(Color("sublineTextGray"))
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.center)
                .frame(width: 311, height: 40, alignment: .center)
                .padding(.bottom, 24)
            
            VkButtonView(with: "Добавить подкаст", navTitle: "Новый подкаст", at: CreatePodcastView(podcastPost: self.post), isActive: true)
                .frame(width: 166, height: 36)
                .padding(.bottom, 272)
        }.onAppear {
            self.post = PodcastPost()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewPodcastView(post: PodcastPost())
    }
}
