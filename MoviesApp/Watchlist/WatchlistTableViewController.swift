//
//  WatchlistTableViewController.swift
//  MoviesApp
//
//  Created by Александр on 19.12.21.
//

import UIKit

class WatchlistTableViewController: UITableViewController {
    
    private let reuseIdentifier = "Cell"
    
    var viewModel: WatchlistViewModelProtocol! {
        didSet {
            viewModel.fetchMovies { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WatchlistViewModel()
        tableView.register(WatchlistTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupNavigationBar()
        tableView.backgroundColor = .black
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = "Your Watchlist"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(white: 0.01, alpha: 0.9)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - Table view data source
extension WatchlistTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WatchlistTableViewCell
        
        cell.viewModel = viewModel.sellViewModel(at: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WatchlistTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(150)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel.deleateSaveMovie(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WatchlistTableViewCell
        cell.contentView.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        cell.backgroundColor = .black
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WatchlistTableViewCell
        cell.contentView.backgroundColor = .black
    }
}
