//
//  CountryListController.swift
//  NewStartPart
//
//  Created by tongyi on 7/9/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit
import PhoneNumberKit

class CountryListController: UITableViewController {
    
    var countries: [Country] = []
    var phoneNumberKit = PhoneNumberKit()
    
    override func viewDidLoad() {
        setup()
    }
    
    private func setup() {
        title = "Country List"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        
        fillCountries()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.fullNameAndCodeString()
        return cell
    }
    
    private func fillCountries() {
        let pairs = getCountryShortAndFullNamePairs()
        
        for (fullName, shortName) in pairs {
            if let code = phoneNumberKit.countryCode(for: shortName) {
                countries.append(Country(code: Int(code), fullName: fullName, shortName: shortName))
            }
        }
    }
    
    private func getCountryShortAndFullNamePairs() -> [(String, String)] {
        
        guard let path = Bundle.main.path(forResource: "countries", ofType: nil) else {
            return []
        }
        
        var countryPair: [(String, String)] = []
        
        if let contents = try? String(contentsOfFile: path, encoding: .utf8) {
            let countries = contents.components(separatedBy: .newlines)
            
            for country in countries {
                let countryItem = country.components(separatedBy: "----")
                if countryItem.count == 2 {
                    countryPair.append((countryItem[0], countryItem[1]))
                }
            }
        }
        
        return countryPair
    }
}
