//
//  WikipediaSearchViewController.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import UIKit

class WikipediaSearchViewController: UIViewController {
    
    @IBOutlet weak private var geonamesTableView: UITableView!
    @IBOutlet weak private var searchTextField: RoundedCornersTextField!
    
    private let presenter = WikipediaSearchPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
        geonamesTableView.register(cellType: GeonameTableViewCell.self)
        searchTextField.becomeFirstResponder()
    }
    
    @IBAction private func searchFieldDidChange(_ sender: RoundedCornersTextField) {
        if let keyword = sender.text {
            presenter.getGeonames(with: keyword)
        }
    }
    
    @IBAction private func searchOptionValueChanged(_ sender: UISegmentedControl) {
        presenter.searchMode.toggle()
    }
}

extension WikipediaSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.geonames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = geonamesTableView.dequeueReusableCell(for: indexPath, cellType: GeonameTableViewCell.self)
        cell.configure(with: presenter.geonames[indexPath.row])
        presenter.fetchImageForGeoname(at: indexPath.row)
        return cell
    }
}

extension WikipediaSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension WikipediaSearchViewController: WikipediaSearchPresenterDelegate {
    
    func geonamesDidUpdate() {
        geonamesTableView.reloadData()
    }
    
    func requestWikiGeonamesFailed() {
        let alert =  UIAlertController(title: "Something went wrong", message: "Check your Internet connection and try again.", preferredStyle: .alert)
        let closeActionButton = UIAlertAction(title: "Close", style: .default)
        alert.addAction(closeActionButton)
        self.present(alert, animated: true)
    }
      
    func didDownloadThumbnailImageForCell(at index: Int) {
        let cell = geonamesTableView.dequeueReusableCell(for: IndexPath(row: index, section: 0), cellType: GeonameTableViewCell.self)
        cell.updateThumbnailImage(with: presenter.geonames[index].thumbnailImgData)
    }
}
