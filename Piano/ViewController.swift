//
//  ViewController.swift
//  Piano
//
//  Created by 萬治佐友里 on 2017/09/07.
//  Copyright © 2017年 Monolith Works Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var startTime: TimeInterval!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x:0, y:0, width: view.frame.width, height: view.frame.height)
        scrollView.center = self.view.center
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
        scrollView.contentOffset.y = CGFloat(scrollView.frame.height)
        scrollView.delegate = self
        
        self.view.addSubview(scrollView)
        
        for j in 0...7 {
            let cellView: UIView = UIView()
            cellView.translatesAutoresizingMaskIntoConstraints = false
            cellView.tag = j
            cellView.frame = CGRect(x:0, y: scrollView.frame.height / 4 * CGFloat(j), width: scrollView.frame.width, height: scrollView.frame.height / 4)
            if j % 2 == 0 {
                cellView.backgroundColor = .blue
            }
            scrollView.addSubview(cellView)
            NSLayoutConstraint.activate([
                cellView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
                cellView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
                cellView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: scrollView.frame.height / 4 * CGFloat(j)),
                cellView.heightAnchor.constraint(equalToConstant: scrollView.frame.height / 4)
                ])
            for i in 0...3 {
                let tapView: UIView = UIView()
                tapView.translatesAutoresizingMaskIntoConstraints = false
                if i == 1 {
                    tapView.backgroundColor = .yellow
                }
                cellView.addSubview(tapView)
                NSLayoutConstraint.activate([
                    tapView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: cellView.frame.width / 4 * CGFloat(i)),
                    tapView.widthAnchor.constraint(equalToConstant: cellView.frame.width / 4),
                    tapView.topAnchor.constraint(equalTo: cellView.topAnchor),
                    tapView.heightAnchor.constraint(equalToConstant: cellView.frame.height)
                    ])
            }
        }
        
        for i in 1...3 {
            let border: UIView = UIView()
            border.translatesAutoresizingMaskIntoConstraints = false
            border.backgroundColor = .black
            view.addSubview(border)
            
            NSLayoutConstraint.activate([
                border.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                border.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 4 * CGFloat(i)),
                border.widthAnchor.constraint(equalToConstant: 1),
                border.heightAnchor.constraint(equalToConstant: view.frame.height)
                ])
        }

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(ViewController.tap(_ :)), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            ])
        
    }
    
    @objc func tap(_ sender: UIButton) {
        print("button")
        /* if sender.isSelected {
         timer.invalidate()
         } else {*/
        startTime = Date().timeIntervalSince1970
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer.fire()
        //   }
    }
    
    @objc func update() {
        // 経過した時間を、現在の時刻-開始時刻で算出(秒)
        let elapsedTime = Date().timeIntervalSince1970 - startTime
        
        // let flooredErapsedTime = Int(floor(elapsedTime))
        
        scrollView.contentOffset.y = CGFloat(scrollView.frame.height - CGFloat(elapsedTime) * 100)
        
        
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}
