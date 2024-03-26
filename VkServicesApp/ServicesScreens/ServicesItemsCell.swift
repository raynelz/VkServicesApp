//
//  itemsCell.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 26.03.2024.
//

import UIKit
import SnapKit

final class ServicesItemsCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .label
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with service: Service) {
        titleLabel.text = service.name
    }

    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(titleLabel)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
}
