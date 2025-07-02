# 🎬 Movie App

A simple iOS Movie Application built with UIKit using the **MVVMC** (Model-View-ViewModel-Coordinator) architecture pattern. The app displays a list of movies fetched from a use case layer, supports marking movies as favorites, and shows detailed information on a separate screen.

---

## 📱 Features

- Display a list of movies in a `UICollectionView`
- Show movie details in a dedicated view
- Toggle favorite status with Core Data persistence
- Compositional layout for modern UI
- Coordinator pattern for navigation flow
- Combine-powered reactive ViewModels
- Clean architecture with testable components

---

## 🧱 Architecture

- **MVVMC** pattern for separation of concerns
- `HomeVC` shows the movie list
- `MovieDetailsVC` displays movie details
- Coordinators handle screen transitions
- `HomeViewModel` and `MovieDetailsViewModel` drive logic and bind to UI
- `HomeUsecase` abstracts data fetching & updating
- `MovieCoreDataStore` handles persistence

---

## 🛠 Technologies Used

- UIKit
- Combine
- Core Data
- Swift Concurrency (async/await)
- Coordinator Pattern
- UICollectionViewCompositionalLayout

---

## 📂 Project Structure

```plaintext
MovieApp/
│
├── Scenes/
│   ├── Home/
│   │   ├── HomeVC.swift
│   │   ├── HomeViewModel.swift
│   │   └── HomeCoordinator.swift
│   └── MovieDetails/
│       ├── MovieDetailsVC.swift
│       ├── MovieDetailsViewModel.swift
│       └── MovieDetailsCoordinator.swift
│
├── Models/
│   └── Movie.swift
│
├── Data/
│   └── MovieCoreDataStore.swift
│
├── Usecases/
│   └── HomeUsecase.swift
│
├── Views/
│   └── MovieCell.xib / MovieCell.swift
│
├── Resources/
│   └── Assets.xcassets
│
└── Persistence/
    └── PersistenceController.swift
