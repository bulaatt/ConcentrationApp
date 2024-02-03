//
//  ViewController.swift
//  Concentration
//
//  Created by Булат Камалетдинов on 29.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipLabel: UILabel!
    @IBOutlet weak public var matchesLabel: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
            flipLabel.text = "Flips: \(ConcentrationGame.flips)"
            matchesLabel.text = "Matches: \(ConcentrationGame.matches)"
            if ConcentrationGame.matches == ((buttonCollection.count + 1) / 2) {
                winAlerting()
            }
        }
    }
    
    lazy var game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)
    var emojiCollection = ["🦊","🐣","🦍","🦧","🧩","🌎","🦋","🦩","🦖","🐯","🐋","🐊"]
    var emojiDictionary = [Int: String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        let font = UIFont.systemFont(ofSize: 50)
        let attributes = [NSAttributedString.Key.font: font]
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setAttributedTitle(NSAttributedString(string: emojiIdentifier(for: card), attributes: attributes), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            } else {
                button.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            }
        }
    }
    
    func winAlerting() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleString = NSAttributedString(string: "Congratulations!", attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        let messageString = NSAttributedString(string: "🐲You are the winner🐲", attributes: messageAttributes)
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        let quitAction = UIAlertAction(title: "Quit", style: .default, handler: {action in exit(0)})
        alert.addAction(quitAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

