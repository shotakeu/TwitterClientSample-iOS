//
//  Tweet.swift
//  twitmorse
//
//  Created by Shotaro Takeuchi on 2018/02/06.
//  Copyright © 2018年 Shotaro Takeuchi. All rights reserved.
//  参考
//  https://qiita.com/ktanaka117/items/e721b076ceffd182123f
//
import Foundation

struct Tweet {
    /** TweetId */
    let id: String
    
    /** TweetText */
    let text: String
    
    /** Tweet User */
    let user: User
}
