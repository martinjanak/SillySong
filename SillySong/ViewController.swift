//
//  ViewController.swift
//  SillySong
//
//  Created by Martin Janák on 18/04/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

let vowelSet = CharacterSet(charactersIn: "aeiou")
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercased()
    
    if lowercaseName.rangeOfCharacter(from: vowelSet) == nil {
        return lowercaseName
    }
    
    var scalars =  lowercaseName.unicodeScalars
    
    while !vowelSet.contains(scalars[scalars.startIndex]) {
        scalars.removeFirst()
    }
    
    return String(scalars)
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    return lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
}


class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text!.characters.count > 0 {
            let sillySong = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
            lyricsView.text = sillySong
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

