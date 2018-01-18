//
//  ViewController.swift
//  scrollCards
//
//  Created by Ankit  Chaudhary on 31/12/17.
//  Copyright © 2017 Ankit  Chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var movieData:[Movie] = []
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            self.changeMovieDetailsUnderneath()
        }
    }
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenreRuntimeReleaseDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var cardSize: CGSize {
        let layout = collectionView.collectionViewLayout as! ScrollCardCollectionViewLayout
        var cardSize = layout.itemSize
        cardSize.width =  cardSize.width + layout.minimumLineSpacing
        return cardSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Register collection view nibs.
        collectionView.register(UINib(nibName: "ScrollCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScrollCardCollectionViewCellIdentifier")
        collectionView.clipsToBounds = false
        
        movieData = Movie.fetchMovieData()
        
        // Set delegate and datasource.
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func changeMovieDetailsUnderneath() {
        
        UILabel.animate(withDuration: 0.8) {
            self.movieName.text = self.movieData[self.currentPage].name
            self.movieGenreRuntimeReleaseDate.text = self.movieData[self.currentPage].genre! + " | " + self.movieData[self.currentPage].runtime! + " | " + self.movieData[self.currentPage].releaseDate!
            self.movieRating.text = self.movieData[self.currentPage].rating!
            self.movieDescription.text = self.movieData[self.currentPage].description
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScrollCardCollectionViewCellIdentifier", for: indexPath) as! ScrollCardCollectionViewCell
        cell.movieImage.image = movieData[indexPath.row].image
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.masksToBounds = true
        
        cell.movieImage.layer.shadowColor = UIColor.lightGray.cgColor
        cell.movieImage.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell.movieImage.layer.shadowRadius = 20
        cell.movieImage.layer.shadowOpacity = 0.2
        cell.movieImage.layer.masksToBounds = false
        cell.movieImage.layer.shadowPath = UIBezierPath(roundedRect: cell.movieImage.layer.bounds, cornerRadius: cell.movieImage.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
}

extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let carSide =  self.cardSize.width
        let offset =  scrollView.contentOffset.x
        currentPage = Int(floor((offset - carSide / 2) / carSide) + 1)
    }
}
