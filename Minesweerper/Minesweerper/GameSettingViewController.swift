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
    var currentV : Float = 0.5
    //let volumeView = MPVolumeView()
    override func viewDidLoad() {
        super.viewDidLoad()
        vibe.setOn(vibes_on, animated: false)
    }
    
    @IBAction func changeVolume(_ sender: Any) {
        let currentV = volume.value
        (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(currentV, animated: false)
        print(currentV)
    }
    @IBAction func switchVibe(_ sender: Any) {
        vibes_on = vibe.isOn
    }
    
    @IBAction func goBack(_ sender: Any) {
        currentV = volume.value
        please()
    }
    func please() {
        self.performSegue(withIdentifier: "goBackLevelSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBackLevelSegue" {
            let gameVLC: GameLevelViewController = segue.destination as! GameLevelViewController
            gameVLC.volume = currentV
            
        }
        //print(currentV)
    }

}
