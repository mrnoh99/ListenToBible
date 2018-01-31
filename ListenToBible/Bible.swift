//
//  Bible.swift
//  ListenToBible
//
//  Created by NohJaisung on 2018. 1. 29..
//  Copyright © 2018년 NohJaisung. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

struct Bible {
    
 
    
    enum Gospel: Int {
        case matthew = 0
        case mark
        case luke
        case john
        
        
        var koreanNameOfGospel: String {
            switch self {
            case .matthew: return "마태오복음서"
            case .mark: return "마르코복음서"
            case .luke: return "루카복음서"
            case .john: return "요한복음서"
            }
        }
        
        var englishNameOfGospel: String {
            switch self {
            case .matthew: return "Gospel of Matthew"
            case .mark: return "Gospel of Mark"
            case .luke: return "Gospel of Luke"
            case .john: return "Gospel of John"
            }
        }
        
        var numberOfChapters: Int {
            switch self {
            case .matthew: return 7 //28
            case .mark: return 7 //16
            case .luke: return 7 //24
            case .john: return  7 //21
            }
        }
        
        var identityCode: String {
            switch self {
            case .matthew: return "147"
            case .mark: return "148"
            case .luke: return "149"
            case .john: return "150"
            }
        }
        
        var gospelNameArray: [String] {
            switch self {
            case .matthew, .mark, .luke, .john:
                var array = [String]()
                for i in 1...self.numberOfChapters {
                    array.append(self.koreanNameOfGospel + " " + "\(i) 장")}
                return array
                
            }
        }
        
        var fileNamesArray: [String] {
            switch self {
            case .matthew, .mark, .luke, .john:
                var array = [String]()
                for i in 1...self.numberOfChapters {
                    array.append(self.identityCode + "_" + "\(i)")}
                return array
                
            }
        }
        
        
        
        
    }
   
  
    
}

func makePlayingCassette(selectedRow:Int, selectedBible:Bible.Gospel) -> (AVQueuePlayer, [String], Int, Int, Bible.Gospel) {
    
    let quePlayer = AVQueuePlayer()
    var array = [String]()
    let startSubscript = 0
    let absolute = selectedRow % (selectedBible.numberOfChapters  )
    
    if absolute == selectedBible.numberOfChapters  {
    for i in 0...selectedBible.numberOfChapters - 1 {
        let urlPath = Bundle.main.path(forResource: selectedBible.fileNamesArray[i], ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath:urlPath!)
        let playerItem = AVPlayerItem(url:fileURL as URL)
        quePlayer.insert(playerItem, after:nil)
        array.append(selectedBible.gospelNameArray[i])
    } }
    
   else if absolute == -1 {
    for i in (selectedBible.numberOfChapters - 1)...selectedBible.numberOfChapters - 1 {
        let urlPath = Bundle.main.path(forResource: selectedBible.fileNamesArray[i], ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath:urlPath!)
        let playerItem = AVPlayerItem(url:fileURL as URL)
        quePlayer.insert(playerItem, after:nil)
        array.append(selectedBible.gospelNameArray[i])
    }
    
    for i in 0...absolute {
        let urlPath = Bundle.main.path(forResource: selectedBible.fileNamesArray[i], ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath:urlPath!)
        let playerItem = AVPlayerItem(url:fileURL as URL)
        quePlayer.insert(playerItem, after:nil)
        array.append(selectedBible.gospelNameArray[i])
    } }
   else if absolute == 0 {
    for i in 0...absolute {
        let urlPath = Bundle.main.path(forResource: selectedBible.fileNamesArray[i], ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath:urlPath!)
        let playerItem = AVPlayerItem(url:fileURL as URL)
        quePlayer.insert(playerItem, after:nil)
        array.append(selectedBible.gospelNameArray[i])
    }   }
   else {
    
    for i in absolute...selectedBible.numberOfChapters - 1 {
        let urlPath = Bundle.main.path(forResource: selectedBible.fileNamesArray[i], ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath:urlPath!)
        let playerItem = AVPlayerItem(url:fileURL as URL)
        quePlayer.insert(playerItem, after:nil)
        array.append(selectedBible.gospelNameArray[i])
    }
    
    for i in 0...absolute - 1 {
        let urlPath = Bundle.main.path(forResource: selectedBible.fileNamesArray[i], ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath:urlPath!)
        let playerItem = AVPlayerItem(url:fileURL as URL)
        quePlayer.insert(playerItem, after:nil)
        array.append(selectedBible.gospelNameArray[i])
    }}
    return (quePlayer, array, startSubscript, absolute, selectedBible)
    
}
    
   

    






