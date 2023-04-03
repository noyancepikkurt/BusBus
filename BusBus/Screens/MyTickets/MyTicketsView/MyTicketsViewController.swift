//
//  MyTicketsViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

class MyTicketsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
    }
    
    private func tableViewRegister() {
        tableView.register(UINib(nibName: "MyTicketsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTicketsCell")
    }

}

extension MyTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketsCell") as! MyTicketsTableViewCell
        return cell
    }
}
