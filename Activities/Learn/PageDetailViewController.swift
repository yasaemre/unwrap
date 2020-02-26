//
//  PageDetailViewController.swift
//  Unwrap
//
//  Created by Home on 9/4/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class PageDetailViewController: UIViewController {
    let chapterName = "variables"
    let titleLabel = UILabel()
    let textView = UITextView(frame: .zero)
    let videoPlayerController = AVPlayerViewController()
    var playerView = AVPlayer()
    let videoPlayerContainer = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Learn", style: .plain, target: self, action: #selector(dismissButtonPressed))
        self.view.addSubview(videoPlayerContainer)
        self.addChild(videoPlayerController)
        self.view.addSubview(videoPlayerController.view)
        self.view.addSubview(textView)
        self.view.addSubview(titleLabel)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = chapterName.capitalized
        displayVideo()
        displayTextView()
    }
    @objc func dismissButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    func displayVideo() {
        videoPlayerController.view.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: view.bounds.width, height: 220)
        let videoUrl = Bundle.main.url(forResource: "variables", withExtension: "mp4")!
        playerView = AVPlayer(url: videoUrl as! URL)
        videoPlayerController.player = playerView
    }
    func displayTextView() {
        textView.frame = CGRect(x: 0, y: self.videoPlayerController.view.frame.maxY, width: view.frame.width, height: self.view.frame.height - 200)
        let content = NSAttributedString(chapterName: chapterName, width: textView.frame.width)
        textView.attributedText = content
        textView.font = UIFont(name: "Courier", size: 16)
        textView.textColor = .white
        textView.backgroundColor = UIColor(displayP3Red: 0.27, green: 0.27, blue: 0.38, alpha: 1)
        textView.isEditable = true
        textView.isSelectable = true
        textView.isScrollEnabled = true
    }
}
