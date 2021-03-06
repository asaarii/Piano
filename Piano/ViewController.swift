//
//  ViewController.swift
//  Piano
//
//  Created by 萬治佐友里 on 2017/09/07.
//  Copyright © 2017年 Monolith Works Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var startTime: TimeInterval!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // Constraint
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tap(_ sender: UIButton) {
        
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
        
        tableView.contentOffset.y = CGFloat(elapsedTime * elapsedTime) * CGFloat(elapsedTime)
    
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1500
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Init
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let container: UIView = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(container)
        
        // Constraints
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor),
            container.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor),
            container.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
//        if indexPath.row % 2 == 0 {
//            container.backgroundColor = .lightGray
//        }
        
        for i in 1...4 {
            let tapView: UIView = UIView()
            tapView.translatesAutoresizingMaskIntoConstraints = false
            tapView.backgroundColor = .black
            
            container.addSubview(tapView)
            
            NSLayoutConstraint.activate([
                tapView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: cell.contentView.frame.width / 4 * CGFloat(i - 1)),
                tapView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                tapView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                tapView.widthAnchor.constraint(equalToConstant: cell.contentView.frame.width / 4)
                ])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

