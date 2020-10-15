//
//  GameViewController.swift
//  MyBoxStackGameApp
//
//  Created by Shugo Matsuo on 2020/09/19.
//  Copyright © 2020 smatsuo. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    let winGameBoxStackNum: Int = 4
    let boxVerMaxNum: Int = 18
    let boxHoriMaxNum: Int = 21
    let boxDefaultColor: [UIColor] = [.systemGray5, .systemBackground]
    
    var turnPlayer = 0
    var playerName: [String] = Array(repeating: "", count: 2)
    var playerColor: [UIColor] = [.green, .orange]
    var boxArray: [[String]] = [[String]](repeating: [String](repeating: "", count: 21), count: 18)
    var prevUIButton: UIButton!
    
    @IBOutlet weak var playerNameField: UILabel!
    
    // ハコボタン 下からカウント
    @IBOutlet var boxButton0: [UIButton]!
    @IBOutlet var boxButton1: [UIButton]!
    @IBOutlet var boxButton2: [UIButton]!
    @IBOutlet var boxButton3: [UIButton]!
    @IBOutlet var boxButton4: [UIButton]!
    @IBOutlet var boxButton5: [UIButton]!
    @IBOutlet var boxButton6: [UIButton]!
    @IBOutlet var boxButton7: [UIButton]!
    @IBOutlet var boxButton8: [UIButton]!
    @IBOutlet var boxButton9: [UIButton]!
    @IBOutlet var boxButton10: [UIButton]!
    @IBOutlet var boxButton11: [UIButton]!
    @IBOutlet var boxButton12: [UIButton]!
    @IBOutlet var boxButton13: [UIButton]!
    @IBOutlet var boxButton14: [UIButton]!
    @IBOutlet var boxButton15: [UIButton]!
    @IBOutlet var boxButton16: [UIButton]!
    @IBOutlet var boxButton17: [UIButton]!
    
    // ゲーム初期化
    @IBAction func restartGame(_ sender: UIBarButtonItem) {
        clearBox(boxButtonArray: boxButton0, index: 0)
        clearBox(boxButtonArray: boxButton1, index: 1)
        clearBox(boxButtonArray: boxButton2, index: 0)
        clearBox(boxButtonArray: boxButton3, index: 1)
        clearBox(boxButtonArray: boxButton4, index: 0)
        clearBox(boxButtonArray: boxButton5, index: 1)
        clearBox(boxButtonArray: boxButton6, index: 0)
        clearBox(boxButtonArray: boxButton7, index: 1)
        clearBox(boxButtonArray: boxButton8, index: 0)
        clearBox(boxButtonArray: boxButton9, index: 1)
        clearBox(boxButtonArray: boxButton10, index: 0)
        clearBox(boxButtonArray: boxButton11, index: 1)
        clearBox(boxButtonArray: boxButton12, index: 0)
        clearBox(boxButtonArray: boxButton13, index: 1)
        clearBox(boxButtonArray: boxButton14, index: 0)
        clearBox(boxButtonArray: boxButton15, index: 1)
        clearBox(boxButtonArray: boxButton16, index: 0)
        clearBox(boxButtonArray: boxButton17, index: 1)
        
        if let prevButton = prevUIButton { prevButton.setTitle("", for: UIControl.State.normal)
        }
        for indexI in 0..<boxVerMaxNum {
            for indexJ in 0..<boxHoriMaxNum {
                boxArray[indexI][indexJ] = ""
            }
        }
        turnPlayer = Int.random(in: 0...1)
        changeTurn()
        for boxArrayV in boxArray {
            print("\(boxArrayV)")
        }
    }
    
    // ボックス初期化
    func clearBox(boxButtonArray: [UIButton], index: Int){
        
        var colorIndex: Int = index
        for boxButton in boxButtonArray {
            boxButton.isEnabled = true
            boxButton.backgroundColor = boxDefaultColor[colorIndex]
            boxButton.layer.borderWidth = 0
            if colorIndex == 0 {
                colorIndex = 1
            }
            else {
                colorIndex = 0
            }
        }
    }
    
    // ハコボタン押下処理
    func selectBoxButton(button: UIButton, y: Int, x: Int){
        if checkBoxStack(y: y, x: x) == true {
            modifyBoxButton(button: button)
            boxArray[y][x] = playerName[turnPlayer]
            prevUIButton = button
            
            // ゲーム終了チェック
            if checkGameWin(y: y, x: x) == true {
                print("Game Finish! Winner : \(playerName[turnPlayer])")
                // ゲーム終了　勝利者表示
                let gameFinishAlert: UIAlertController = UIAlertController(title: "ゲーム終了！！", message: "Winner:  \(playerName[turnPlayer])", preferredStyle: UIAlertController.Style.alert)
                
                gameFinishAlert.addAction(UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(gameFinishAlert, animated: true, completion: nil)
            }
            
            changeTurn()
        }
        else {
            print("[WAR]Not Set Box")
        }
    }
    
    // ハコボタンのハコ積み後設定
    func modifyBoxButton(button: UIButton){
        button.backgroundColor = playerColor[turnPlayer]
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.isEnabled = false
        button.setTitle("●", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        if let prevButton = prevUIButton {
            prevButton.setTitle("", for: UIControl.State.normal)
        }
    }
    
    // ターン切り替え
    func changeTurn() {
        if turnPlayer == 0 {
            turnPlayer = 1
        }
        else {
            turnPlayer = 0
        }
        playerNameField.text = playerName[turnPlayer]
        playerNameField.textColor = playerColor[turnPlayer]
    }
    
    // ハコが置けるかチェック
    func checkBoxStack(y: Int, x: Int) -> Bool {
        print("checkBoxStack y: \(y), x: \(x)")
        
        if y == 0 {
            return true
        }
        if boxArray[y - 1][x] != "" {
            return true
        }
        else {
            return false
        }
    }
    
    // ゲーム勝利チェック
    func checkGameWin(y: Int, x: Int) -> Bool {
        print("checkWinGame y: \(y), x: \(x)")
        for boxArrayV in boxArray {
            print("\(boxArrayV)")
        }
        // 縦方向チェック
        if checkGameWinVertical(y: y, x: x) == true {
            return true
        }
        
        // 横方向チェック
        if checkGameWinSub(y: y, x: x, ver: 0) == true {
            return true
        }
        
        // 斜め右上方向チェック
        if checkGameWinSub(y: y, x: x, ver: 1) == true {
            return true
        }
        
        // 斜め右下方向チェック
        if checkGameWinSub(y: y, x: x, ver: -1) == true {
            return true
        }
        
        return false
    }
    
    // 縦方向の勝利チェック
    func checkGameWinVertical(y: Int, x: Int) -> Bool {
        
        var result: Bool = true
        // 縦方向は-方向のみ
        for ver in (1...3) {
            if (y - ver) >= 0 {
                if boxArray[y - ver][x] != playerName[turnPlayer] {
                    result = false
                }
            }
            else {
                result = false
            }
        }
        return result
    }
    
    // 横・斜め方向の勝利チェック
    func checkGameWinSub(y: Int, x: Int, ver: Int) -> Bool {
        
        var result: Bool = false
        var connectBoxNum = 1
        var verMove: Int = 0
        // +方向
        for hori in (1...3) {
            verMove += ver
            if (x + hori) < boxHoriMaxNum &&
                (y + verMove) < boxVerMaxNum &&
                (y + verMove) >= 0 {
                print("hori+ y: \(y + verMove), x: \(x + hori), name: \(boxArray[y + verMove][x + hori])")
                if boxArray[y + verMove][x + hori] == playerName[turnPlayer] {
                    connectBoxNum += 1
                }
                else {
                    break
                }
            }
        }
        print("checkGameWinSub hori+ connectBoxNum: \(connectBoxNum)")
        // -方向
        verMove = 0
        for hori in (1...3) {
            verMove -= ver
            if (x - hori) >= 0 &&
                (y + verMove) < boxVerMaxNum &&
                (y + verMove) >= 0 {
                print("hori- y: \(y + verMove), x: \(x - hori), name: \(boxArray[y + verMove][x - hori])")
                if boxArray[y + verMove][x - hori] == playerName[turnPlayer] {
                    connectBoxNum += 1
                }
                else {
                    break
                }
            }
        }
        print("checkGameWinSub hori- connectBoxNum: \(connectBoxNum)")
        
        if connectBoxNum >= 4 {
            result = true
        }
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        turnPlayer = Int.random(in: 0...1)
        print("Game Start turn:\(turnPlayer)")
        playerNameField.text = playerName[turnPlayer]
        playerNameField.textColor = playerColor[turnPlayer]
        
        for boxArrayV in boxArray {
            print("\(boxArrayV)")
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // ハコボタン押下 下から0行目
    @IBAction func selecteBox0(_ sender: UIButton) {
        print("selectBox0 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 0, x: sender.tag)
    }
    
    // ハコボタン押下 下から1行目
    @IBAction func selecteBox1(_ sender: UIButton) {
        print("selectBox1 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 1, x: sender.tag)
    }
    
    // ハコボタン押下 下から2行目
    @IBAction func selecteBox2(_ sender: UIButton) {
        print("selectBox2 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 2, x: sender.tag)
    }
    
    // ハコボタン押下 下から3行目
    @IBAction func selecteBox3(_ sender: UIButton) {
        print("selectBox3 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 3, x: sender.tag)
    }
    
    // ハコボタン押下 下から4行目
    @IBAction func selecteBox4(_ sender: UIButton) {
        print("selectBox4 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 4, x: sender.tag)
    }
    
    // ハコボタン押下 下から5行目
    @IBAction func selecteBox5(_ sender: UIButton) {
        print("selectBox5 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 5, x: sender.tag)
    }
    
    // ハコボタン押下 下から6行目
    @IBAction func selecteBox6(_ sender: UIButton) {
        print("selectBox6 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 6, x: sender.tag)
    }
    
    // ハコボタン押下 下から7行目
    @IBAction func selecteBox7(_ sender: UIButton) {
        print("selectBox7 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 7, x: sender.tag)
    }
    
    // ハコボタン押下 下から8行目
    @IBAction func selecteBox8(_ sender: UIButton) {
        print("selectBox8 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 8, x: sender.tag)
    }
    
    // ハコボタン押下 下から9行目
    @IBAction func selecteBox9(_ sender: UIButton) {
        print("selectBox9 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 9, x: sender.tag)
    }
    
    // ハコボタン押下 下から10行目
    @IBAction func selecteBox10(_ sender: UIButton) {
        print("selectBox10 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 10, x: sender.tag)
    }
    
    // ハコボタン押下 下から11行目
    @IBAction func selecteBox11(_ sender: UIButton) {
        print("selectBox11 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 11, x: sender.tag)
    }
    
    // ハコボタン押下 下から12行目
    @IBAction func selecteBox12(_ sender: UIButton) {
        print("selectBox12 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 12, x: sender.tag)
    }
    
    // ハコボタン押下 下から13行目
    @IBAction func selecteBox13(_ sender: UIButton) {
        print("selectBox13 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 13, x: sender.tag)
    }
    
    // ハコボタン押下 下から14行目
    @IBAction func selecteBox14(_ sender: UIButton) {
        print("selectBox14 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 14, x: sender.tag)
    }
    
    // ハコボタン押下 下から15行目
    @IBAction func selecteBox15(_ sender: UIButton) {
        print("selectBox15 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 15, x: sender.tag)
    }
    
    // ハコボタン押下 下から16行目
    @IBAction func selecteBox16(_ sender: UIButton) {
        print("selectBox16 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 16, x: sender.tag)
    }
    
    // ハコボタン押下 下から17行目
    @IBAction func selecteBox17(_ sender: UIButton) {
        print("selectBox17 tag: \(sender.tag)")
        
        selectBoxButton(button: sender, y: 17, x: sender.tag)
    }
    
}
