//
//  TimelineViewController.swift
//  twitmorse
//
//  Created by Shotaro Takeuchi on 2018/02/06.
//  Copyright © 2018年 Shotaro Takeuchi. All rights reserved.
//
import UIKit
import TwitterKit

/**
 * - reference
 * https://qiita.com/ktanaka117/items/e721b076ceffd182123f ←deprecated
 * https://o-tyazuke.hatenablog.com/entry/2016/11/23/123748
 */
class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var rightBarButton: UIBarButtonItem!
    
    // テーブル表示用のデータソース
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var prototypeCell: TWTRTweetTableViewCell?
    var userId: String?
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 投稿ボタン
        rightBarButton = UIBarButtonItem(
            title: "tweet",
            style: .plain,
            target: self,
            action: #selector(tappedRightBarButton(_:))
        )
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        prototypeCell = TWTRTweetTableViewCell(style: .default, reuseIdentifier: "cell")
        
        tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        loadTweets()
        // バックボタン消しておく
        self.navigationItem.hidesBackButton = true
    }
    
    func loadTweets(){
        TwitterAPI.getHomeTimeline(user: userId, tweets: {
            twttrs in
            for tweet in twttrs {
                print(tweet)
                self.tweets.append(tweet)
            }
        }, error: {
            error in
            print(error.localizedDescription)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TWTRTweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        cell.configure(with: tweet)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        
        prototypeCell?.configure(with: tweet)
        
        if let height: CGFloat = TWTRTweetTableViewCell.height(for: tweet, style: .regular, width: self.view.bounds.width, showingActions: true){
            return height
        }else{
            return tableView.estimatedRowHeight
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func tappedRightBarButton(_ sender: UIBarButtonItem!){
        let composer = TWTRComposer()
        
        composer.show(from: self, completion: {
            result in
            if (result == TWTRComposerResult.cancelled){
                print("tweet composetion cancelled")
            }else{
                self.loadTweets()
                self.tableView.reloadData()
                print("sending tweet!!")
            }
        })
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        // ここに通信処理などデータフェッチの処理を書く
        // データフェッチが終わったらUIRefreshControl.endRefreshing()を呼ぶ必要がある
        self.loadTweets()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}
