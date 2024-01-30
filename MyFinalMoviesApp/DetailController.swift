//
//  DetailController.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 5.11.2023.
//


import UIKit
import SDWebImage

class DetailController: UIViewController {
    
    var modelDetail : ModelDetailFor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail Screen"
        
        view.addSubview(titleLabel)
        setUpTitleLabelConstraint()
        
        view.addSubview(yearLabel)
        setUpYearLabelConstraint()
        
        view.addSubview(myImageView)
        setUpPosterImageConstraint()
        
         view.addSubview(declarationLabel)
        SetUpDeclerationLabelConstraint()
        
     /*   view.addSubview(myScrollView)
        setUpScrollViewConstraint()
        myScrollView.addSubview(declarationLabel)
        SetUpDeclerationLabelConstraint() */
        
        view.backgroundColor = .white
        print("Şuanda DETAY EKRANINDAYIM.")
        
        DispatchQueue.main.async {
            
            print(self.modelDetail)
          
            self.yearLabel.text = self.modelDetail?.year
            self.titleLabel.text = self.modelDetail?.title
            self.myImageView.sd_setImage(with: URL(string: self.modelDetail?.poster ?? "dd"))
            self.declarationLabel.text = self.modelDetail?.plot
          
        }
        
    }
    
   
    private let titleLabel : UILabel = {
        
        let myLabelim = UILabel()
        myLabelim.font =  UIFont.systemFont(ofSize: 30,weight: .bold)
        myLabelim.textAlignment = .center
        myLabelim.numberOfLines = 0
        myLabelim.translatesAutoresizingMaskIntoConstraints = false
        return myLabelim
    }()
    private func setUpTitleLabelConstraint(){
    
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
       }
    
    
    private let yearLabel : UILabel = {
     
        let myLabel = UILabel()
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.textAlignment = .center
        myLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        
        return myLabel
        
    }()
    private func setUpYearLabelConstraint(){
        
        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 5).isActive = true
        
        yearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -35).isActive = true
        
    }
    
    
    private let myImageView : UIImageView = {
       
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    private func setUpPosterImageConstraint() {
        myImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        myImageView.bottomAnchor.constraint(equalTo:titleLabel.topAnchor , constant: -20).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
       
    }
    
    
    private let declarationLabel : UITextView = {
        
        let myTextView = UITextView()
        
        myTextView.translatesAutoresizingMaskIntoConstraints = false
        myTextView.textColor = .gray
        myTextView.textAlignment = .left
        myTextView.font = UIFont.systemFont(ofSize: 25)
        myTextView.isEditable = false
        //mylabel.numberOfLines = 0
        
        return myTextView
        
    }()
    private func SetUpDeclerationLabelConstraint() {
        
        declarationLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 0).isActive = true
        declarationLabel.leadingAnchor.constraint(equalTo: myImageView.leadingAnchor, constant: 10).isActive = true
        declarationLabel.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10).isActive = true
        declarationLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
 
    
    
}
