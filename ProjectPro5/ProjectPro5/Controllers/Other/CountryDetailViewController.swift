//
//  CountryDetailViewController.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import UIKit

class CountryDetailViewController: UIViewController {

    private let viewModel: CountryDetailViewViewModel
    
    init(viewModel: CountryDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title

        
    }


}
