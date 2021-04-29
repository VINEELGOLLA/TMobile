//
//  ViewController.swift
//  tmobile
//
//  Created by naga vineel golla on 4/23/21.
//

import UIKit

class SearchViewController: UIViewController {
    var searchViewModel = SearchViewModel(networkManager: NetworkManager())
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.defaultIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "reddit search"
        view.backgroundColor = .white
        view.addSubview(tableView)
        searchViewModel.delegate = self
        tableView.pin(to: view)
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    func updateLoadingStatus(isloading: Bool) {
        if isloading == false {
            DispatchQueue.main.async {
                self.tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
    func didFinishFetch() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func spinnerFooter() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: UIScreen.main.bounds.width, height: CGFloat(44))
        return spinner
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchViewModel.redditData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell(style: .default, reuseIdentifier: Constants.defaultIdentifier)}
            cell.redditTitle.text = self.searchViewModel.redditData[indexPath.row].title
            cell.comment.text = "Comments: " + String(self.searchViewModel.redditData[indexPath.row].numComments ?? 0)
            cell.score.text = "Score: " + String(self.searchViewModel.redditData[indexPath.row].score ?? 0)
            cell.redditImage.downloaded(from: self.searchViewModel.redditData[indexPath.row].thumbnail ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let width = self.searchViewModel.redditData[indexPath.row].thumbnailWidth, let height = self.searchViewModel.redditData[indexPath.row].thumbnailHeight{
            let ratio = CGFloat(width / height)
            return tableView.frame.width / ratio + 120
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.searchViewModel.redditData.count - 1 {
            if let _ = self.searchViewModel.nextLink {
                self.tableView.tableFooterView = spinnerFooter()
                self.tableView.tableFooterView?.isHidden = false
            }
            self.searchViewModel.fetchData()
        }
    }
}

