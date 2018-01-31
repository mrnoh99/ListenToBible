//
//  ViewController.swift
//  ListenToBible
//
//  Created by NohJaisung on 2018. 1. 29..
//  Copyright © 2018년 NohJaisung. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class ViewController: UIViewController   {
    
     var gospel = Bible.Gospel.matthew
    var nowPlayingGospel = Bible.Gospel.matthew
     var  qplayer = AVQueuePlayer()
     var bibleNameSequenceArray = [String]()
     var nowplayingAbsoluteChapterSubscript = 0
    
    var nowPlayingRelativeChapterSubscript: Int = 0 {
        didSet {
            littleLabel.text = bibleNameSequenceArray[nowPlayingRelativeChapterSubscript]        }
    }
    
    
    
    @IBOutlet weak var littleLabel: UILabel!
    @IBAction func bibleSelection(_ sender: UISegmentedControl) {
      
        switch sender.selectedSegmentIndex {
        case 0:
            gospel = .matthew
        case 1:
            gospel = .mark
        case 2:
            gospel = .luke
        case 3:
            gospel = .john
        default:
            gospel = .matthew
            
        }
        self.myTableView.reloadData()
        
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var togglePlayButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
     
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerChangedChapter(note:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil)
        
        togglePlayButton.setImage(UIImage(named:"play.png" ), for: UIControlState.normal)
        (qplayer,bibleNameSequenceArray, nowPlayingRelativeChapterSubscript, nowplayingAbsoluteChapterSubscript, nowPlayingGospel) =  makePlayingCassette(selectedRow: 0 , selectedBible: gospel)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playPalusePressed(_ sender: UIButton) {
        togglePlayPause()
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        playPrevious()
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        playNext()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gospel.numberOfChapters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
        cell.cellLabel.text = gospel.gospelNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        (qplayer,bibleNameSequenceArray, nowPlayingRelativeChapterSubscript, nowplayingAbsoluteChapterSubscript,nowPlayingGospel) =  makePlayingCassette(selectedRow: indexPath.row, selectedBible: gospel)
         self.myTableView.reloadData()
        playCassette()
        
        
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
}

extension ViewController: AVAudioPlayerDelegate {
    
    func playCassette() {
        qplayer.play()
       
    }
    
    @objc  func playerChangedChapter(note:NSNotification) {
        self.modifyVariable(relative:  &nowPlayingRelativeChapterSubscript, absolute: &nowplayingAbsoluteChapterSubscript)
      
        
    }
    
    func modifyVariable(relative:inout Int, absolute:inout Int){
        if relative < bibleNameSequenceArray.count - 1 {
            relative += 1 }
        if absolute < gospel.numberOfChapters - 1 {
            absolute += 1 } else { absolute = 0}
        }
    
    
func togglePlayPause() {
    if qplayer.rate > 0 {
        qplayer.pause()
        togglePlayButton.setImage(UIImage(named:"play.png" ), for: UIControlState.normal)
     
    }
    else {
        qplayer.play()
        togglePlayButton.setImage(UIImage(named:"pause.png" ), for: UIControlState.normal)
        
        
         }
        
   }
    
    func playNext(){
        qplayer.pause()
        togglePlayButton.setImage(UIImage(named:"play.png" ), for: UIControlState.normal)
        (qplayer,bibleNameSequenceArray, nowPlayingRelativeChapterSubscript, nowplayingAbsoluteChapterSubscript, nowPlayingGospel) =  makePlayingCassette(selectedRow: nowplayingAbsoluteChapterSubscript + 1 , selectedBible: nowPlayingGospel)
        
    }
    func playPrevious(){
        qplayer.pause()
        togglePlayButton.setImage(UIImage(named:"play.png" ), for: UIControlState.normal)
        (qplayer,bibleNameSequenceArray, nowPlayingRelativeChapterSubscript, nowplayingAbsoluteChapterSubscript, nowPlayingGospel) =  makePlayingCassette(selectedRow: nowplayingAbsoluteChapterSubscript - 1 , selectedBible: nowPlayingGospel)
        
    }
   
    
}
