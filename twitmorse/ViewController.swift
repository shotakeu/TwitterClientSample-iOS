//
//  ViewController.swift
//  twitmorse
//
//  Created by Shotaro Takeuchi on 2018/02/06.
//  Copyright © 2018年 Shotaro Takeuchi. All rights reserved.
//  参考
//  https://qiita.com/ktanaka117/items/e721b076ceffd182123f
//  https://o-tyazuke.hatenablog.com/entry/2016/11/23/123748
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // すでにログイン済みか
        if !hasTwitterAuth() {
        self.navigationItem.title = "login"
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                                              message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertController.Style.alert
                )
                NSLog("このはげええええええええ1")
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                //self.present(alert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "timeline", sender: session)
                NSLog("このはげええええええええ2")
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
                NSLog("このはげええええええええ")
            }
        }
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
        } else {
            self.performSegue(withIdentifier: "timeline", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let session = sender as? TWTRSession
        let dest = segue.destination as! TimelineViewController
        dest.title = session?.userName
        dest.userId = session?.userID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     * Twitter 認証済みかどうか
     */
    func hasTwitterAuth() -> Bool {
        if TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            return true
        }
        return false
    }

}

