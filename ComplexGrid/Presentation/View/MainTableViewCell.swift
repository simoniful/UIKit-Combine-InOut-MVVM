//
//  MainTableViewCell.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/25.
//

import UIKit
import SnapKit
import Kingfisher

final class MainTableViewCell: UITableViewCell {
  static let identifier = "MainTableViewCell"
  
  lazy var containerView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.addArrangedSubview(movieImageView)
    stackView.addArrangedSubview(infoView)
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 15.0
    stackView.contentMode = .scaleToFill
    return stackView
  }()
  
  lazy var infoView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.addArrangedSubview(movieNameLabel)
    stackView.addArrangedSubview(movieDescLabel)
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 5.0
    stackView.contentMode = .scaleToFill
    return stackView
  }()
  
  lazy var movieImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  lazy var movieNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15.0)
    label.numberOfLines = 0
    return label
  }()
  
  lazy var movieDescLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13.0)
    label.textColor = .darkGray
    label.numberOfLines = 0
    return label
  }()
  
  var movieObject: Result! {
    didSet {
      setupData()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    [containerView].forEach {
      contentView.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    containerView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10.0)
      $0.leading.equalToSuperview().offset(15.0)
      $0.trailing.equalToSuperview().offset(-15.0)
      $0.bottom.equalToSuperview().offset(-10.0)
    }
    
    movieImageView.snp.makeConstraints {
      $0.height.equalTo(60.0)
      $0.width.equalTo(movieImageView.snp.height)
    }
  }
  
  private func setupData() {
    guard let unwrappedMovieName = movieObject.title,
          let unwrappedMovieDetails = movieObject.overview
    else { return }
    
    movieNameLabel.text = unwrappedMovieName
    movieDescLabel.text = unwrappedMovieDetails
    
    if let unwrappedMovieImage = movieObject.backdrop_path,
       let imageURL = URL(string: Service.imageBase + unwrappedMovieImage) {
      movieImageView.kf.setImage(
        with: imageURL,
        placeholder: UIImage(named: "placeholder-image")
      )
    }
  }
}
