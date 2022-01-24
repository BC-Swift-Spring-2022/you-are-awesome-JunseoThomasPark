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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad ran...")
        messageLabel.text = "Amazeballs"
        messageCounter.text = ""
        
    }
    
    var counter = 0
    @IBAction func messageButton(_ sender: UIButton) {
        print("Button Pressed...")
        counter = counter + 1
        messageLabel.text = "You are Awesome!"
        messageLabel.textColor = UIColor.gray
        messageCounter.text = "Button pressed " + String(counter) + " times"
        messageCounter.textColor = UIColor.purple
    }
    
    @IBAction func quoteButton(_ sender: UIButton) {
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




