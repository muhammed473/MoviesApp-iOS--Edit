//
//  HomeForCellCollectionViewCell.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 4.11.2023.
//

import UIKit
import SDWebImage

class HomeForCellCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "cell"
    
    let movieImage : UIImageView = {
     
     let image = UIImageView()
     image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
     return image
        
     }()
    
    let movieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
 /*  private func setUpConstraint(){
     
        self.contentView.addSubview(movieImage)
        self.contentView.addSubview(movieTitle)
        
        movieImage.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant: 2 ).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 2).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 2).isActive = true
        movieImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 2).isActive = true
        
        movieTitle.topAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 5).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 2).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 2).isActive = true
        movieTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 2).isActive = true
                  
    }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(movieImage)
        addSubview(movieTitle)
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        movieImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        movieImage.layer.cornerRadius = 20 // Resimin köşelerini hafif yuvarladık.
        movieImage.layer.masksToBounds = true // sınırlarımı ayarladığımı söylemiş oldum.
        
      
        movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor,constant: 10).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    //    movieTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init(coder:NSCoder) {
        fatalError("İnit(coder) : has not been implemented yani KODLAYICI OLUŞAMADI ( BAŞLAMADI.")
    }
    
}
