//
//  ViewController.swift
//  RestAPIAndJSON
//
//  Created by Владимир on 05.03.2022.
//

import UIKit

class FilmsViewController: UIViewController {
//MARK: -Properties
   let cellindentifier = "cell with JSON"
    var array = [FilmsViewModel]()
    var copyArray = [FilmsViewModel]()
//MARK: -Views
    private lazy var tableView : UITableView = {
       let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsSelection = false
        tableView.rowHeight = 93
        tableView.backgroundColor = .white
        return tableView
    }()
    private lazy var searchBar : UISearchBar = {
       let search = UISearchBar()
        return search
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FilmsCell.self, forCellReuseIdentifier: cellindentifier )
        restAPI()
        setupDelegate()
        setupSearchBar()
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
    }
//MARK: -Private methods
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    private func setupDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func setupConstraints() {
            tableView.snp.makeConstraints {maker in
                maker.left.right.equalToSuperview().inset(16)
                maker.top.bottom.equalToSuperview().inset(70)
            }
        searchBar.snp.makeConstraints{maker in
            maker.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    private func setupSearchBar() {
        searchBar.delegate = self

    }
    private func restAPI(){
        let url = URL(string: "https://imdb-api.com/API/Search/k_6hekvavf/sasha")
        LoadData.shared.FilmsInfo(url: url!, responce: {[weak self]info, error in
            if error == nil {
                guard let info = info else { return}
                self?.array = info.results
                self?.copyArray = self!.array
                print(self?.copyArray)
                self?.tableView.reloadData()
            }
            else {print(error!.localizedDescription)}
        })
    }
  }
//MARK: -Extesion
extension FilmsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.copyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellindentifier) as? FilmsCell
        let viewModel =  self.copyArray[indexPath.row]
        cell?.configure(viewModel)
        return cell ?? UITableViewCell()
    }
}
extension FilmsViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.copyArray = searchText.isEmpty ? self.array : self.array.filter({ (array) -> Bool in
            return array.title!.range(of: searchText,options: .caseInsensitive, range: nil , locale: nil) != nil
        })
        tableView.reloadData()
    }
    
}
