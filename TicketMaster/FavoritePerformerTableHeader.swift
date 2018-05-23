//
//  FavoritePerformerTableHeader.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FavoritePerformerTableHeaderDelegate {
    func relayDidPressSearchBar()
    func relayDidPressHeaderCell(indexPath: IndexPath)
}

class FavoritePerformerTableHeader: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    var favoritePerformerTableHeaderDelegate: FavoritePerformerTableHeaderDelegate!
    var searchBar: UISearchBar!
    var labelContainerView = UIView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    private var separatorLine = UIView()
    private let cellIdentifier = "cell"
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.clipsToBounds = true
        collectionView.isScrollEnabled = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup SearchBar
        searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.placeholder = "searchPerformersPlaceholder".localized()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
        
        //Setup Label Container View
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelContainerView)
        
        //Setup Title Label
        titleLabel.text = "favoritesTabTitleLabel".localized()
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.labelContainerView.addSubview(titleLabel)
        
        //Setup SubTitle Label
        subTitleLabel.text = "favoritesTabSubtitleLabel".localized()
        subTitleLabel.textColor = .darkGray
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.labelContainerView.addSubview(subTitleLabel)
        
        //Setup CollectionView
        collectionView.register(FavoriteMusicSourceCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        
        //Setup SeparatorLine
        separatorLine.backgroundColor = TMColor.faintGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorLine)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.labelContainerView.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.labelContainerView.addSubview(spacerViewBottom)
        
        let viewDict = ["searchBar": searchBar, "labelContainerView": labelContainerView, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "collectionView": collectionView, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom, "separatorLine": separatorLine] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: searchBar, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: searchBar, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.95, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[labelContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: labelContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: subTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: labelContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .centerX, relatedBy: .equal, toItem: labelContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .centerX, relatedBy: .equal, toItem: labelContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: labelContainerView, attribute: .width, multiplier: 0.95, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: labelContainerView, attribute: .width, multiplier: 0.95, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .width, relatedBy: .equal, toItem: labelContainerView, attribute: .width, multiplier: 0.95, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .width, relatedBy: .equal, toItem: labelContainerView, attribute: .width, multiplier: 0.95, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[searchBar]-1-[labelContainerView]-1-[collectionView(100)]-[separatorLine(1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.labelContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[spacerViewTop][titleLabel(<=20)]-2-[subTitleLabel(<=40)][spacerViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .height, relatedBy: .equal, toItem: spacerViewBottom, attribute: .height, multiplier: 1, constant: 0))
        self.labelContainerView.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .height, relatedBy: .equal, toItem: spacerViewTop, attribute: .height, multiplier: 1, constant: 0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicSourceTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: (collectionView.frame.width/CGFloat(musicSourceTitles.count)), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FavoriteMusicSourceCell
        cell.configure(title: musicSourceTitles[indexPath.row].localized(), image: musicSourceImages[indexPath.row]!)
        return cell
    }
    
    //CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favoritePerformerTableHeaderDelegate.relayDidPressHeaderCell(indexPath: indexPath)
    }
    
    //SearchBar Delegate
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        favoritePerformerTableHeaderDelegate.relayDidPressSearchBar()
        return false
    }
}
