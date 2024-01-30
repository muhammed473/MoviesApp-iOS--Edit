//
//  ViewController.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 4.11.2023.
//

import UIKit
import SDWebImage

class HomeController: UIViewController {

    var myCollectionView : UICollectionView!
    let apiService = ApiService()
    var myList = [ExampleModelHome]()
    var searchResultList = [ExampleModelHome]()
    var movieModel : ExampleModelHome?
    var isSearch = false
    
   // var myScrollView : UIScrollView?
   
  // var imageList = [posterModel]()
    var b = MyNavigationController()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  view.addSubview(myScrollView!)
        myScrollView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myScrollView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myScrollView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myScrollView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true */
        
        view.backgroundColor = .white
        navigationItem.title = "Movie App"
        
        settleCollectionView()
        constraintCollectionView()
        
        view.addSubview(mySearchBar)
        setUpSearchBarConstraint()
      
        mySearchBar.delegate = self
       
        
      /*  apiService.fetchData(page: 1, {
            
            (generalDictModelList) in
            
            self.myList = generalDictModelList.myMovies!
            print("Film sayısı : \(self.myList.count) " )
           
        } */
        
        apiService.fetchData(page: 1, completion: {
            (generalDictModelList) in
            self.myList = generalDictModelList.myMovies!
            print("Film sayısı : \(self.myList.count) " )

         })
        
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
        
        
        
        
    }
    
    
    
    private func settleCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let screenWidth = view.frame.width
        layout.itemSize = CGSize(width: screenWidth/2.5, height: screenWidth/4)
        myCollectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 50
        
        view.addSubview(myCollectionView)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        constraintCollectionView()
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        myCollectionView.register(HomeForCellCollectionViewCell.self, forCellWithReuseIdentifier: HomeForCellCollectionViewCell.cellIdentifier)
    }

    private func constraintCollectionView() {
        
        myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 55).isActive = true
        myCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true // leadingAnchor : Sol çapa
        myCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true // trailingAnchor : Sağ çapa
        myCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true //
                
    }

    private let mySearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
            
        
    }()
    
    private func setUpSearchBarConstraint() {
        
        mySearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0).isActive = true
        mySearchBar.leadingAnchor.constraint(equalTo: myCollectionView.leadingAnchor,constant: 2).isActive = true
        mySearchBar.trailingAnchor.constraint(equalTo: myCollectionView.trailingAnchor,constant: 2).isActive = true
     // mySearchBar.bottomAnchor.constraint(equalTo: myCollectionView.topAnchor,constant: 5).isActive = true
        
    }
    
    
    
}

extension HomeController: UICollectionViewDelegate,UICollectionViewDataSource{ // extension : İlave
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // Bölümdeki öğe sayısı
       //  return self.myList.count
        
        if searchBarIsEmpty() {
            return myList.count
        }
        else {
            return searchResultList.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // Hücre sayısı
        
       
      /*  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeForCellCollectionViewCell.cellIdentifier, for: indexPath)  as! HomeForCellCollectionViewCell
        
       
        cell.movieImage.sd_setImage(with: URL(string: self.myList[indexPath.row].poster ) )
        
        return cell */
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeForCellCollectionViewCell.cellIdentifier, for: indexPath)  as! HomeForCellCollectionViewCell
       
        
        if !searchBarIsEmpty() {
            cell.movieTitle.text = searchResultList[indexPath.row].title
            cell.movieImage.sd_setImage(with: URL(string: self.searchResultList[indexPath.row].poster))
        }
        else {
            cell.movieTitle.text = myList[indexPath.row].title
            cell.movieImage.sd_setImage(with: URL(string: self.myList[indexPath.row].poster ) )
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      /*  print("İlgili filme tıklandı ! ! ! ")
        
        let detailController = DetailController()
        let ChooseMovieId = self.myList[indexPath.row].imdbID
       
        
       DispatchQueue.main.async {
         
           if !self.searchBarIsEmpty() {
               
               self.apiService.fetchDetailData(imdbID: ChooseMovieId)
               {
               (modelDetay) in
               
               print("Api'deki Fetch Detail Datanın modelDetay bilgileri : \(modelDetay)")
               print("Tıkladığım filmin id'si : \(self.myList[indexPath.row].imdbID)")
               detailController.modelDetail = modelDetay
               
               }
           }
           
           else {
               let searchResultMovieId = self.myList[indexPath.row].imdbID
               
               self.apiService.fetchDetailData(imdbID: searchResultMovieId) {
                   (modelDetay) in
                   
                   
                 //  print("Tıkladığım filmin id'si : \(self.searchResultList[indexPath.row].imdbID)")
                   detailController.modelDetail = modelDetay
                   
                   }
               }
           
           }
           
        
         
     self.navigationController?.pushViewController(detailController, animated: true) */
         
        
        
        
        print("İlgili filme tıklandı ! ! ! ")
          
          let detailController = DetailController()
        let myListId = self.myList[indexPath.row].imdbID
        
          
         DispatchQueue.main.async {
           
             if !self.searchBarIsEmpty() {
                 
                 let ChooseMovieId = self.searchResultList[indexPath.row].imdbID
                 
                 self.apiService.fetchDetailData(imdbID: ChooseMovieId)
                 {
                 (modelDetay) in
                 
                 print("Api'deki Fetch Detail Datanın modelDetay bilgileri : \(modelDetay)")
                 print("Tıkladığım filmin id'si : \(self.searchResultList[indexPath.row].imdbID)")
                 detailController.modelDetail = modelDetay
                 
                 }
             }
             
             else {
              
                 
                 self.apiService.fetchDetailData(imdbID: myListId) {
                     (modelDetay) in
                     
                    
                   //  print("Tıkladığım filmin id'si : \(self.searchResultList[indexPath.row].imdbID)")
                     detailController.modelDetail = modelDetay
                     
                     }
                 }
             
             }
             
          
           
       self.navigationController?.pushViewController(detailController, animated: true)
    }
        
        
}




extension HomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        print ("ARAMA YAPILIYOR")
        searchResultList = self.myList.filter({ (s : ExampleModelHome )
            -> Bool in
            return s.title.lowercased().contains(searchText.lowercased() )
        })
      
        isSearch = true
        
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
       
        
    }
    
    func searchBarIsEmpty() -> Bool {
        
        return mySearchBar.text?.isEmpty ?? true
    }
    
}


