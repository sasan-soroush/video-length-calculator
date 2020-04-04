//
//  ViewController.swift
//  video length calculator
//
//  Created by Sasan Soroush on 4/4/20.
//  Copyright © 2020 Sasan Soroush. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    @IBOutlet weak var VideoLengthLabel: NSTextField!
    
    private let supportedExtensions = ["mp4",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func ChooseLocationTapped(_ sender: NSButton) {
        
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose the folder that contains videos.";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories    = true;
        dialog.canChooseFiles          = false;
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url
            if (result != nil) {
                if let res = result {
                    do {
                        // Get the directory contents urls (including subfolders urls)
                        let files = try FileManager.default.contentsOfDirectory(at: res, includingPropertiesForKeys: nil)
                        var totalDuration : Double = 0.0
                        files.forEach { (url) in
                            let asset = AVURLAsset(url: url)
                            let durationInSeconds = asset.duration.seconds
                            totalDuration += durationInSeconds
                        }
                        VideoLengthLabel.stringValue = totalDuration.asString()

                    } catch {
                        print(error)
                    }
                }
            }
        } else {
            return
        }
    }

    @IBAction func ChooseVideosTapped(_ sender: NSButton) {
        
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose videos.";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.allowsMultipleSelection = true;
        dialog.canChooseDirectories    = false;
        dialog.canChooseFiles          = true;
        dialog.allowedFileTypes        = Constants.supportedVideoFormats;
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let videoFiles = dialog.urls
            var totalDuration : Double = 0.0
            videoFiles.forEach { (url) in
                let asset = AVURLAsset(url: url)
                let durationInSeconds = asset.duration.seconds
                totalDuration += durationInSeconds
            }
            VideoLengthLabel.stringValue = totalDuration.asString()
        } else {
            return
        }
    }
}

