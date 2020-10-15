//
//  ViewController.swift
//  MyBoxStackGameApp
//
//  Created by Shugo Matsuo on 2020/09/15.
//  Copyright © 2020 smatsuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    let segmentColor: [UIColor] = [.green, .orange, .cyan, .purple]
    var playerName: [String] = ["Player1","Player2"]
    var playerColor: [UIColor] = [.green, .orange]
    var player1ColorSegmentNum: Int = 0
    var player2ColorSegmentNum: Int = 1
    
    @IBOutlet weak var player1Name: UITextField!
    @IBOutlet weak var player2Name: UITextField!
    
    @IBOutlet weak var player1Color: UISegmentedControl!
    @IBOutlet weak var player2Color: UISegmentedControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameView" {
            let gameVC = segue.destination as! GameViewController
            gameVC.playerName = self.playerName
            gameVC.playerColor = self.playerColor
        }
    }
    
    @IBAction func gameStart(_ sender: UIButton) {
        if let name = player1Name.text {
            if name != "" {
                playerName[0] = name
            }
            else {
                playerName[0] = "Player1"
            }
        }
        if let name = player2Name.text {
            if  name != "" {
                playerName[1] = name
            }
            else {
                playerName[1] = "Player2"
            }
        }
    }
    
    @IBAction func changePlayer1Color(_ sender: UISegmentedControl) {
        print("Player1BeforeColor Color: \(player1ColorSegmentNum)")
        print("changePlayer1Color Color: \(sender.selectedSegmentIndex)")
        
        player2Color.setEnabled(true, forSegmentAt: player1ColorSegmentNum)
        player1ColorSegmentNum = sender.selectedSegmentIndex
        player2Color.setEnabled(false, forSegmentAt: player1ColorSegmentNum)
        playerColor[0] = segmentColor[player1ColorSegmentNum]
        player1Color.selectedSegmentTintColor = playerColor[0]
        player1Name.textColor = playerColor[0]
    }
    @IBAction func changePlayer2Color(_ sender: UISegmentedControl) {
        print("Player2BeforeColor Color: \(player2ColorSegmentNum)")
        print("changePlayer2Color Color: \(sender.selectedSegmentIndex)")
        
        player1Color.setEnabled(true, forSegmentAt: player2ColorSegmentNum)
        player2ColorSegmentNum = sender.selectedSegmentIndex
        player1Color.setEnabled(false, forSegmentAt: player2ColorSegmentNum)
        playerColor[1] = segmentColor[player2ColorSegmentNum]
        player2Color.selectedSegmentTintColor = playerColor[1]
        player2Name.textColor = playerColor[1]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        player1Color.setEnabled(false, forSegmentAt: player2ColorSegmentNum)
        player2Color.setEnabled(false, forSegmentAt: player1ColorSegmentNum)
        
        player1Name.delegate = self
        player2Name.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
}

