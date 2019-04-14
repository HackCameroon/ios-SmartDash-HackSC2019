////
////  CollectionViewControllerCell.swift
////  SimilarityGroupingDemo
////
////  Created by Ritesh Pakala on 4/2/19.
////  Copyright © 2019 Ritesh Pakala. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class CollectionViewControllerCell : UICollectionViewCell {
//	
//	let imageView : UIImageView = UIImageView()
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		
//		imageView.contentMode = .scaleAspectFit
//		imageView.translatesAutoresizingMaskIntoConstraints = false
//		self.contentView.addSubview(imageView)
//		imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//		imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
//		imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
//		imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
//	}
//	
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//	
//	override func prepareForReuse() {
//		super.prepareForReuse()
//		self.backgroundColor = UIColor.clear
//		self.layer.borderWidth = 0.0
//	}
//	
//	func updateImage(with : UIImage) {
//		imageView.image = with
//		
//	}
//}
