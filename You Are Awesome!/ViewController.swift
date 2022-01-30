//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by Thomas Park on 1/24/22.
//

import UIKit

struct Quote: Decodable{
    let quote: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageCounter: UILabel!
    @IBOutlet weak var messageQuote: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad ran...")
        messageLabel.text = "Amazeballs"
        messageCounter.text = ""
        messageCounter.text = ""
        messageQuote.text = ""
        
    }
    
    var counter = 0
    @IBAction func messageButton(_ sender: UIButton) {
        print("Button Pressed...")
        counter = counter + 1
        
        let imageNum = Int.random(in: 1...7)
        print(imageNum)
        messageLabel.textColor = UIColor.gray
        messageCounter.text = "Button pressed " + String(counter) + " times"
        messageCounter.textColor = UIColor.purple
        
        if messageLabel.text == "You are Awesome!"{
            messageLabel.text = "You are Great!"
            imageView.image = UIImage(named: "image"+String(imageNum))
            
        }
        else {
            messageLabel.text = "You are Awesome!"
            imageView.image = UIImage(named: "image"+String(imageNum))
        }
        
        
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




