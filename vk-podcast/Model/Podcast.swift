//
//  Podcast.swift
//  vk-podcast
//
//  Created by milkyway on 16.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import Foundation

struct Podcast {
    private(set) var title: String?
    private(set) var description: String?
    
    private(set) var explicitContent = false
    private(set) var excludeFromExport = false
    private(set) var podcastTrailer = false
    
    private(set) var timeCodes = [TimeCode]()
    
    mutating func pushTimeCode(time: String?, title: String?) {
        timeCodes.append(TimeCode(time: time, title: title))
    }
    
    mutating func setTimecodeTitle(value: String, at i: Int) {
        timeCodes[i].title = value
    }
    
    mutating func setTimecodeTime(value: String, at i: Int) {
        timeCodes[i].time = value
    }
    
    struct TimeCode: Identifiable {
        fileprivate init(time: String? = nil, title: String? = nil) {
            self.time = time
            self.title = title
        }
        var time: String?
        var title: String?
        let id = UUID()
    }
    
    mutating func setTitle(_ text: String) {
        title = text
    }
    
    mutating func setDescription(_ text: String) {
        description = text
    }
    
    mutating func switchExplicitContent() {
        explicitContent = !explicitContent
    }
    
    mutating func switchExcludeFromExport() {
        excludeFromExport = !excludeFromExport
    }
    
    mutating func switchPodcastTrailer() {
        podcastTrailer = !podcastTrailer
    }
    
    mutating func removeElement(at index: Int) {
        timeCodes.remove(at: index)
    }
    
}
