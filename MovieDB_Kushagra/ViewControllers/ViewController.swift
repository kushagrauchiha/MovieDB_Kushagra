// ViewController.swift
import UIKit
import Combine
import NetworkingSDK

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let viewModel = MoviesViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var movieDetails: MovieDetails?
    private var movieListType: String
    
    init(movieListType: String) {
        self.movieListType = movieListType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bindViewModel()
        self.title = movieListType
        if movieListType == "Popular" {
            viewModel.getPopularMovies()
        } else if movieListType == "Latest" {
            viewModel.getLatestMovies()
        }
        
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (view.frame.width - 30) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        let id = movie.id
        NetworkManager.shared.fetchMovieDetails(movieId: id) { result in
            switch result {
            case .success(let movieDetails):
                print("Movie Details: \(movieDetails)")
                // Now you can pass `movieDetails` to another function or part of your code
                self.movieDetails = movieDetails
                self.handleMovieDetails(movieDetails)
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }
    
    func handleMovieDetails(_ movieDetails: MovieDetails) {
        // Use the movie details as needed
        print("Handling movie details: \(movieDetails)")
        DispatchQueue.main.async {
            let detailVC = MovieDetailViewController(movieDetails: movieDetails)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
