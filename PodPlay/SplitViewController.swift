//
//  SplitViewController.swift
//  PodPlay
//
//  Created by Nishanth P on 2/13/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    @IBOutlet weak var podListItem: NSSplitViewItem!
    @IBOutlet weak var episodeItem: NSSplitViewItem!
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
