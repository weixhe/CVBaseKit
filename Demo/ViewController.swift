//
//  ViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/18.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataSource = ["Global", "Device"]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: Nav_Height, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - Nav_Height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

}

// MARK: - Lift Cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(tableView)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch dataSource[indexPath.row] {
        case "Global":
            let demoVC = DemoViewController(demo: GlobalDemo())
            self.navigationController?.pushViewController(demoVC, animated: true)
        case "Device":
            let demoVC = DemoViewController(demo: DeviceDemo())
            self.navigationController?.pushViewController(demoVC, animated: true)
        default:
            break
            
        }
        
    }
}
