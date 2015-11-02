//
//  ViewController.swift
//  SDKTestAppSwift
//
//  Created by Lacy Rhoades on 10/7/15.
//  Copyright © 2015 Lacy Rhoades. All rights reserved.
//

import UIKit

import WildcardSDK

class ViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = UITextView()
        textView.dataDetectorTypes = [UIDataDetectorTypes.Link]
        textView.delegate = self
        textView.selectable = true
        textView.text = "This is a test. This is a link: http://www.theatlantic.com OK?"
        textView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(textView)
        
        let metrics = ["margin": 100]
        let views = ["textView": textView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[textView]|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[textView]|", options: [], metrics: metrics, views: views))
        
        let URL = NSURL(string: "http://www.washingtonpost.com/news/wonkblog/wp/2015/10/06/for-decades-the-government-steered-millions-away-from-whole-milk-was-that-wrong/")
        Card.getFromUrl(URL,
            completion: { (card:Card?, error:NSError?) -> Void in
                if let card = card {
                    self.presentCard(card, animated: true, completion: nil)
                }else{
                    UIApplication.sharedApplication().openURL(URL!)
                }
        })
    }

    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        Card.getFromUrl(URL,
            completion: { (card:Card?, error:NSError?) -> Void in
                if let card = card {
                    self.presentCard(card, animated: true, completion: nil)
                }else{
                    UIApplication.sharedApplication().openURL(URL)
                }
        })
        return false
    }
}

