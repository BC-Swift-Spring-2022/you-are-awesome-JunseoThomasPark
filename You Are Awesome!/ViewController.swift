//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by Thomas Park on 1/24/22.
//

import UIKit
import AVFoundation

struct Quote: Decodable{
    let quote: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageCounter: UILabel!
    @IBOutlet weak var messageQuote: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playSoundSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad ran...")
        messageLabel.text = "Amazeballs"
        messageCounter.text = ""
        messageQuote.text = ""
    }
    
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name){
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            }
            catch {
                print("ERROR: \(error.localizedDescription) Could not initialize AVAudioPlayer Object")
            }
        } else {
            print("ERROR: Could not read data from file sound")
        }
    }
    
    func nonRepeatingRandom(originalNumber: Int, upperLimit: Int) -> Int{
        var newNumber: Int
        repeat{
            newNumber = Int.random(in: 0...upperLimit)
        } while originalNumber == newNumber
        return newNumber
    }
     
    var counter = 0
    var imageNumber = -1
    var messageNumber = -1
    var soundNumber = -1
    let totalNumberOfImages = 7
    let totalNumberOfSounds = 6
    var audioPlayer:AVAudioPlayer!
    
    @IBAction func playSoundToggled(_ sender: UISwitch) {
        if !sender.isOn && audioPlayer != nil{ //if False
            audioPlayer.stop()
        }
        
    }
    
    @IBAction func messageButton(_ sender: UIButton) {
        let messages = ["You are Awesome",
                        "You are Great",
                        "You are Fantastic",
                        "Fab, that's you!",
                        "You are awesome like Kanye",
                        "Kanye loves you",
                        "Kanye told me he was thinking about you while rapping"]
        
        //message number creation
        messageNumber = nonRepeatingRandom(originalNumber: messageNumber, upperLimit: messages.count-1)
        messageLabel.text = messages[messageNumber]
        
        //image number creation
        imageNumber = nonRepeatingRandom(originalNumber: messageNumber, upperLimit: totalNumberOfImages-1)
        imageView.image = UIImage(named: "image\(imageNumber)")
        
        //sound number creation
        soundNumber = nonRepeatingRandom(originalNumber: soundNumber, upperLimit: totalNumberOfSounds-1)
        if playSoundSwitch.isOn {
            playSound(name: "sound\(soundNumber)")
        }
        
        
        print("Button Pressed...")
        counter = counter + 1
        messageLabel.textColor = UIColor.gray
        messageCounter.text = "Button pressed " + String(counter) + " times"
        messageCounter.textColor = UIColor.purple
        
        // kanye quote api stuff //
        let urlString = "https://api.kanye.rest/"
        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { [self](data, response, error) in
            guard let data = data else {return}
            _ = String(data: data, encoding: .utf8)
            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                print(quote.quote)
                DispatchQueue.main.async {messageQuote.text = quote.quote + " -Kanye"}
                
            }
            catch let jsonErr{
                print("Error json ", jsonErr)
            }
            
        }.resume()
    }
    
    

}




