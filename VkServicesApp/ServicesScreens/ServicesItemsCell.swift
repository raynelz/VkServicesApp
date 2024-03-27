//
//  itemsCell.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 26.03.2024.
//

import UIKit
import SnapKit

final class ServicesItemsCell: UITableViewCell {

    private lazy var progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView()
        progressView.style = .medium
        return progressView
    }()

    private lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        return icon
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        return label
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
        iconImageView.cacheImage(urlString: service.iconURL) { [weak self] isLoading in
            isLoading ? self?.startAnimation() : self?.stopAnimation()
        }
        descriptionLabel.text = service.description
    }

    private func setupViews() {
        contentView.backgroundColor = .clear
        separatorInset.left = 95
        accessoryType = .disclosureIndicator
        contentView.addSubviews(iconImageView, titleLabel, descriptionLabel)
        iconImageView.addSubview(progressView)
    }

    private func setupLayout() {
            progressView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })

            iconImageView.snp.makeConstraints({
                $0.leading.equalToSuperview().offset(10)
                $0.height.width.equalTo(60)
                $0.top.equalToSuperview().inset(10)
                $0.bottom.lessThanOrEqualToSuperview().offset(-10)
            })

            titleLabel.snp.makeConstraints({
                $0.top.equalTo(iconImageView.snp.top)
                $0.leading.equalTo(iconImageView.snp.trailing).offset(15)
                $0.trailing.lessThanOrEqualToSuperview().offset(-10)
            })

            descriptionLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(5)
                $0.leading.equalTo(titleLabel.snp.leading)
                $0.trailing.equalToSuperview().offset(-10)
                $0.bottom.equalToSuperview().offset(-10)
            }
        }
    private func startAnimation() {
        progressView.startAnimating()
    }

    private func stopAnimation() {
        progressView.stopAnimating()
    }
}
