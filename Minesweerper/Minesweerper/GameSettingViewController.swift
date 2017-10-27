//
//  GameSettingViewController.swift
//  Minesweerper
//
//  Created by Dan Luo on 10/26/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

var vibes_on : Bool = false

class GameSettingViewController: UIViewController {
    
    @IBOutlet weak var volume: UISlider!
    @IBOutlet weak var vibe: UISwitch!
    //let volumeView = MPVolumeView()
    override func viewDidLoad() {
        super.viewDidLoad()
        vibe.setOn(false, animated: false)
    }
    
    @IBAction func changeVolume(_ sender: Any) {
        var currentV = self.volume.value
        (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(currentV, animated: false)
    }
    @IBAction func switchVibe(_ sender: Any) {
        vibes_on = vibe.isOn
    }
}
