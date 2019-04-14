////
////  StillImageViewController.swift
////  PolarrFoundation
////
////  Created by Daniel Vershinin on 13/02/2019.
////  Copyright © 2019 Polarr, Inc. All rights reserved.
////
//
//import UIKit
//import Metal
//import MetalKit
//import Photos
//import CoreServices
//import AVFoundation
//import MetalPerformanceShaders
//
//open class CollectionViewController : UIViewController {
//	
//	fileprivate let logoView : UIImageView = {
//		let logoView = UIImageView()
//		logoView.alpha = 0.5
//		logoView.image = UIImage(contentsOfFile: Bundle(for: CollectionViewController.self).path(forResource: "Logo", ofType: "png")!)
//		logoView.translatesAutoresizingMaskIntoConstraints = false
//		logoView.contentMode = .scaleAspectFit
//		return logoView
//	}()
//	
//	fileprivate let imageView : UIImageView = {
//		let uiImageView = UIImageView(frame: CGRect.zero)
//		uiImageView.translatesAutoresizingMaskIntoConstraints = false
//		return uiImageView
//	}()
//	
//	open override var prefersStatusBarHidden: Bool {
//		return true
//	}
//	
//	let collectionView : UICollectionView = {
//		let flowLayout = UICollectionViewFlowLayout()
//		flowLayout.minimumLineSpacing = 0
//		flowLayout.minimumInteritemSpacing = 0
//		flowLayout.scrollDirection = .vertical
//		flowLayout.itemSize = CGSize(width: 100, height: 100)
//		flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30.0, right: 0)
//		let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
//		collection.translatesAutoresizingMaskIntoConstraints = false
//		
//		return collection
//	}()
//	
//	var images : [[UIImage]] = [[UIImage]]()
//	
//	open override func viewDidLoad() {
//		super.viewDidLoad()
//		
//		
//		self.view.addSubview(collectionView)
//		self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//		self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//		self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//		self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//		self.collectionView.delegate = self
//		self.collectionView.dataSource = self
//		self.collectionView.register(CollectionViewControllerCell.self, forCellWithReuseIdentifier: "groupingCell")
//		self.collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader")
//		
//		
//		self.view.addSubview(logoView)
//		
//		self.logoView.widthAnchor.constraint(equalToConstant: 50).isActive = true
//		self.logoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//		self.logoView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
//		self.logoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
//		
//	}
//	
//	func updateImages(with imagesToUpdate : [[UIImage]]) {
//		self.images = imagesToUpdate
//		
//		self.collectionView.collectionViewLayout.invalidateLayout()
//		self.collectionView.reloadData()
//		
//	}
//}
//
//extension CollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupingCell", for: indexPath) as? CollectionViewControllerCell else {
//			return UICollectionViewCell()
//		}
//		
//		cell.imageView.image = self.images[indexPath.section][indexPath.item]
//		
//		return cell
//	}
//	
//	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return images.count > 0 ? images[section].count : 0
//	}
//	
//	public func numberOfSections(in collectionView: UICollectionView) -> Int {
//		return images.count
//	}
//	
//	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		return CGSize(width: 100, height: 100)
//	}
//	
//	public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//		
//		if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
//			
//			sectionHeader.sectionHeaderLabel.text = "Group \(indexPath.section + 1)"
//			
//			return sectionHeader
//		}
//		return UICollectionReusableView()
//	}
//	
//	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//		return CGSize(width: collectionView.bounds.width, height: 70)
//	}
//	
//}
//
//class SectionHeader: UICollectionReusableView {
//	var sectionHeaderLabel : UILabel!
//	
//	override init(frame: CGRect){
//		super.init(frame: frame)
//		
//		
//		awakeFromNib()
//	}
//	override func awakeFromNib() {
//		sectionHeaderLabel = UILabel()
//		sectionHeaderLabel.textColor = UIColor.white
//		sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
//		sectionHeaderLabel.textColor = UIColor.white
//		sectionHeaderLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
//		self.addSubview(sectionHeaderLabel)
//		
//		sectionHeaderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20.0).isActive = true
//		sectionHeaderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20.0).isActive = true
//		sectionHeaderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//	}
//	
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//}
//
