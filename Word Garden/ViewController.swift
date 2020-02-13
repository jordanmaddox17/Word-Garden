//
//  ViewController.swift
//  Word Garden
//
//  Created by Jordan Maddox on 2/11/20.
//  Copyright © 2020 Jordan Maddox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetter: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = ["SWIFT", "DOG", "CAT", "FAMILY"]
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad", guessedLetter.isFirstResponder)
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        
    }
    
    func updateUIAfterGuess(){
        guessedLetter.resignFirstResponder()
        guessedLetter.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetter.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        //decrements the wrongGuessesRemaining and shows the next flower image with one less pedal
        let currentLetterGuessed = guessedLetter.text!
        if !wordToGuess.contains(guessedLetter.text!) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower" + "\(wrongGuessesRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        //Stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetter.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Sorry, You're All Out Of Guesses. Try Again?"
        } else  if !revealedWord.contains("_"){
            //you've wona  game
            playAgainButton.isHidden = false
            guessedLetter.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've Got It! It Took You \(guessCount) Guesses To Guess The Word!"
        } else {
            //update our guess count
            let guess = (guessCount == 1 ? "Guess" : "Guesses")
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
        
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetter.text?.last {
            guessedLetter.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //disable the botton if I don't have a single character in the guessedLetterFiled
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    

    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton  ) {
        playAgainButton.isHidden = true
        guessedLetter.isEnabled = false
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }
    
    
}

