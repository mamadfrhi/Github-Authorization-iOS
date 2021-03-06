//
//  RepoCell.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import SDWebImage



class RepoTableviewCell: UITableViewCell {
    
    //MARK: Init
    init(repo: GitRepo) {
        super.init(style: .default, reuseIdentifier: nil)
        setupViews()
        nameLabel.text = repo.name
        self.selectionStyle = .none
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    private func setupViews() {
        // Whole cell height is 70
        
        self.accessoryType = .disclosureIndicator
        
        // Owner Image
        self.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.size.equalTo(50)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        // Repo Label name
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp_rightMargin).offset(20)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        // Star Imageview
        self.addSubview(starIgView)
        starIgView.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp_bottomMargin)
            make.size.equalTo(30)
        }
        // Star Count Label
        self.addSubview(starCountLabel)
        starCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(starIgView.snp.right)
            make.centerY.equalTo(starIgView.snp.centerY)
            make.width.equalTo(50)
        }
        
    }
    
    var repoViewModel : RepoRowViewModel? {
        didSet {
            nameLabel.text = repoViewModel?.nameText
            starCountLabel.text = repoViewModel?.starsCount
            imgView.sd_setImage(with: repoViewModel?.imageUrl)
        }
    }
    
    //MARK:- Views
    //MARK: ImageViews
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "user_placeholder")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    private let starIgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "star")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    //MARK: Labels
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "نام ندارد."
        return label
    }()
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = "0"
        return label
    }()
}

//MARK:- Selection Style
extension RepoTableviewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            //                       #ffe700ff
            self.contentView.backgroundColor = UIColor(hex: "#c3f1ffff")
        }else {
            self.contentView.backgroundColor = .clear
        }
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            UIView.animate(withDuration: 0.3) {
                self.contentView.backgroundColor = UIColor(hex: "#c3f1ffff")
            }
            self.shake()
        }
    }
}
