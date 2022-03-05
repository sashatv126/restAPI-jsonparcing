//
//  FilmsCell.swift
//  RestAPIAndJSON
//
//  Created by Владимир on 05.03.2022.
//

import UIKit
import SnapKit

class FilmsCell : UITableViewCell {
//MARK: -Views
    private lazy var label : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = Constants.Fonts.font1
        return label
    }()
    private lazy var label1 : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = Constants.Fonts.font2
        return label
    }()
    private lazy var label2 : UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = Constants.Fonts.font2
        return label
    }()
    private lazy var imageOfStack: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
//MARK: -Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageOfStack)
        contentView.addSubview(label)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        setupConstraints()
        onLoad()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: -Public methods
    func configure(_ viewModel : FilmsViewModel){
        if let url = URL(string : viewModel.image) {
            Service.shared.loadInfo(url: url , completion: { [weak self]result in
                switch result {
                
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.imageOfStack.image = image
                case .failure(let error):
                    self?.imageOfStack.image = nil
                    print(error.localizedDescription)
                }
            })
        }
        label.text = viewModel.title
        label1.text = viewModel.resultType
        label2.text = viewModel.description
        
        
    }
//MARK: -Private methods
    private func onLoad() {
        
    }
    private func setupConstraints() {
        contentView.snp.makeConstraints{maker in
            maker.left.right.equalTo(safeAreaLayoutGuide)
            maker.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        imageOfStack.snp.makeConstraints{ maker in
            maker.width.equalTo(50)
            maker.height.equalTo(50)
            maker.left.equalTo(contentView).inset(0)
            maker.bottom.equalTo(contentView).inset(27)
            maker.top.equalTo(contentView).inset(16)
        }
        label.snp.makeConstraints{maker in
            maker.top.equalTo(contentView).inset(16)
            maker.left.equalTo(imageOfStack).inset(86)
            maker.height.equalTo(19)
        }
        label1.snp.makeConstraints{maker in
            maker.top.equalTo(label).inset(27)
            maker.left.equalTo(imageOfStack).inset(86)
            maker.height.equalTo(34)
        }
        label2.snp.makeConstraints{maker in
            maker.top.equalTo(contentView).inset(16)
            maker.right.equalTo(contentView).inset(0)
            maker.width.equalTo(100)
            maker.height.equalTo(70)
        }
    }
}
