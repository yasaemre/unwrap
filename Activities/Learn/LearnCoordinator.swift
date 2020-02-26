//
//  LearnCoordinator.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import AVKit
import SwiftEntryKit
import UIKit

/// Manages everything launched from the Learn tab in the app.
class LearnCoordinator: Coordinator, Awarding, Skippable, UISplitViewControllerDelegate {
    var splitViewController = PortraitSplitViewController()
    var primaryNavigationController = CoordinatedNavigationController()
    var activeStudyReview: StudyReview!

    /// Whether or not the user can have multiple attempts at questions
    let retriesAllowed = true

    init() {
        // Set up the master view controller
        primaryNavigationController.navigationBar.prefersLargeTitles = true
        primaryNavigationController.coordinator = self

        let chapter = Chapter(name: "variables", sections: ["variables"], bundleNameSections: nil)
        let viewController = PageDetailViewController(nibName: nil, bundle: nil)
        primaryNavigationController.viewControllers = [viewController]

        splitViewController.viewControllers = [primaryNavigationController]
        splitViewController.tabBarItem = UITabBarItem(title: "Learn", image: UIImage(bundleName: "Learn"), tag: 1)

        // make this split view controller behave sensibly on iPad
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = SplitViewControllerDelegate.shared
    }

    /// Shows a short message after the user has finished reading a chapter, but before review starts.
    func showPostscript() {
        assert(activeStudyReview.postscript.isEmpty == false, "Attempting to show empty post script.")

        let alert = AlertViewController.instantiate()
        alert.title = activeStudyReview.title
        alert.alertType = .postscript
        alert.body = activeStudyReview.postscript.fromSimpleHTML()
        alert.presentAsAlert()
    }

    // Single select reviews come in groups of eight.
    func titleSuffix(for item: Sequenced) -> String {
        return " (\(item.questionNumber)/8)"
    }

    func show(url: URL) {
        let viewController = WebViewController(url: url)
        let detailNav = CoordinatedNavigationController(rootViewController: viewController)
        splitViewController.showDetailViewController(detailNav, sender: self)
    }
}
