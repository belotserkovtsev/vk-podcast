//
//  PodcastPost.swift
//  vk-podcast
//
//  Created by milkyway on 16.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import SwiftUI

class PodcastPost: ObservableObject {
    @Published var podcast: Podcast
    
    init(title: String? = nil, description: String? = nil) {
        self.podcast = Podcast(title: title, description: description)
    }
    
    var timeCodes: [Podcast.TimeCode] {
        podcast.timeCodes
    }
    
    var title: String? {
        podcast.title
    }
    
    var description: String? {
        podcast.description
    }
    
    var explicitContent: Bool {
        podcast.explicitContent
    }
    
    var excludeFromExport: Bool {
        podcast.excludeFromExport
    }
    
    var podcastTrailer: Bool {
        podcast.podcastTrailer
    }
    
    //Intents:
    
    func setTimecodeTitle(for item: Podcast.TimeCode , value: String) {
        if let elementIndex = podcast.timeCodes.firstIndex(where: { $0.id == item.id }) {
            podcast.setTimecodeTitle(value: value, at: elementIndex)
        }
    }
    
    func setTimecodeTime(for item: Podcast.TimeCode , value: String) {
        if let elementIndex = podcast.timeCodes.firstIndex(where: { $0.id == item.id }) {
            podcast.setTimecodeTime(value: value, at: elementIndex)
        }
    }
    
    func updateTitle(_ text: String) {
        podcast.setTitle(text)
    }
    
    func updateDescription(_ text: String) {
        podcast.setDescription(text)
    }
    
    func switchExplicitContent() {
        podcast.switchExplicitContent()
    }
    
    func switchExcludeFromExport() {
        podcast.switchExcludeFromExport()
    }
    
    func switchPodcastTrailer() {
        podcast.switchPodcastTrailer()
    }
    
    func pushTimeCode(at time: String? = nil, title: String? = nil) {
        podcast.pushTimeCode(time: time, title: title)
    }
    
    func clearEmptyTimeCodes() {
        while let indexOfEmpty = timeCodes.firstIndex(where: { $0.title == nil || $0.time == nil}) {
            podcast.removeElement(at: indexOfEmpty)
        }
    }
    
}
