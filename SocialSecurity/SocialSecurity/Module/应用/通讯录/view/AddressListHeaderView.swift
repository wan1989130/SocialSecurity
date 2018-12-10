//
//  AddressListHeaderView.swift
//  LogisticsManagerProject
//
//  Created by 王岩 on 2018/11/11.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
protocol AddressListSearchProtocol {
    func searchClick(_ content:String)->Void
}
class AddressListHeaderView: UIView {

    @IBOutlet weak var search: UISearchBar!
    var delegate:AddressListSearchProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        search.delegate = self
    }

}
extension AddressListHeaderView:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate.searchClick(searchBar.text ?? "")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""{
            delegate.searchClick("")
        }
    }
    
}
