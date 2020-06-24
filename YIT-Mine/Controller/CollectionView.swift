//
//  CollectionView.swift
//  YIT-Mine
//
//  Created by moran levi on 09/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UISearchBarDelegate{
    
    //outlets
    @IBOutlet weak var searchBarTF: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    let defaults = UserDefaults.standard
    var selectedIndex:Int = 0
    var pageNumber:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenConfig()
    }
    
    //actions
    @IBAction func searchBtn(_ sender: Any) {
        
        if !self.searchBarTF.text!.isEmpty{
            
            self.pageNumber = 1
            DataManager.getSharedInstance().clearImagesInfo()
            searchImage(searchKey: self.searchBarTF.text!)
            saveSearchResult()
        }
        //save it to memory
        self.saveSearchResult()
        
        self.view.endEditing(true)
    }
    
    private func saveSearchResult(){
        //Set
        defaults.set(searchBarTF.text, forKey: "searched text")
    }
    
    private func screenConfig() {
        collectionConfiguration()
        setDefaultSearch()
    }
    
    private func setDefaultSearch(){
        self.searchBarTF.text = defaults.string(forKey: "searched text")
        searchImage(searchKey: self.searchBarTF.text!)
    }
    
   
    private func collectionConfiguration(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.estimatedItemSize = CGSize(width: 50, height: 50)
                layout.itemSize = UICollectionViewFlowLayout.automaticSize
            }
        self.collectionView.register(UINib(nibName: Constant.Identifier.collectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.imageCellId.rawValue)
    }
    
    private func searchImage(searchKey: String){
        ServerManager.getSharedInstance().getImages(searchKey: searchKey, pageNum: String(self.pageNumber)) { (result) in
            switch result{
            case .failure(_):
                print("faiulre in searching the items")
            case .success(let imagesInfo):
                DataManager.getSharedInstance().setImagesInfo(imagesInfo: imagesInfo)
                self.collectionView.reloadData()
                if DataManager.getSharedInstance().getImagesInfo().isEmpty{
                    print("no image exist")
                    self.emptySearchData()
                }
            }
        }
        
    }
    
    private func emptySearchData(){
        let alert = UIAlertController(title: "NO IMAGES", message: "PLEASE TRY AGAIN ANOTHER KEYWORD.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! FullImageVC
        VC.index = self.selectedIndex
    }
}

extension CollectionView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.getSharedInstance().getImagesInfo().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.imageCellId.rawValue, for: indexPath) as! ImageCell
        cell.setCell(infoImage: DataManager.getSharedInstance().getImagesInfo()[indexPath.row])
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        //  print(self.selectedIndex)
        performSegue(withIdentifier: Constant.Identifier.swipingVCSegue.rawValue, sender: self)
    }
    
    
    // scrolling
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        let reload_distance:CGFloat = 10.0
        if y > (h + reload_distance) {
            self.pageNumber = pageNumber + 1
            searchImage(searchKey: self.searchBarTF.text!)
        }
    }
}
