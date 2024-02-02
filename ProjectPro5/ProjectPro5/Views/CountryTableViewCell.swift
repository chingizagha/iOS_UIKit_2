//
//  CountryTableViewCell.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CountryTableViewCell"
    
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CountryTableViewCell.cellIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(customImageView)
        contentView.addSubview(nameLabel)
        setUpLayer()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpLayer() {
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
                    
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 60),
            customImageView.heightAnchor.constraint(equalToConstant: 40),
            
        
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customImageView.image = nil
        nameLabel.text = nil
    }
    
    public func configure(with viewModel: CountryTableViewCellViewModel) {
        nameLabel.text = viewModel.countryName
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    self?.customImageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
        
    }
    

}
