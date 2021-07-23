//
//  PrefectureViewController.swift
//  APIForPrefecture
//
//  Created by ちいつんしん on 2021/07/13.
//

import UIKit

class PrefectureViewController: UIViewController {

    @IBOutlet private weak var myTableView: UITableView!
    private var prefNames: [String] = []
    private var prefCode: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self

        PrefectureRepostiroy.fetchData(completion: {(prefData) in

            for prefCount in 0..<prefData.result.count {
                self.prefNames.append(prefData.result[prefCount].prefName)
                self.prefCode.append(prefData.result[prefCount].prefCode)
            }

            DispatchQueue.main.sync {
                self.myTableView.reloadData()
            }
        })
    }
}

extension PrefectureViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }
}

extension PrefectureViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prefNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = prefNames[indexPath.row]

        cell.detailTextLabel?.text = "\(prefCode[indexPath.row])番目の都道府県です"

        let colors: [UIColor] = [#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]

        cell.backgroundColor = colors[indexPath.row % colors.count]

        return cell
    }

}
