//
//  PizzaListsViewController.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

protocol IMenuViewController: AnyObject {
    func showPizzaViewModel(pizzaViewModels: MenuViewModel)
    func scrollViewTo(index: Int)
}

final class MenuViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var menuViewModel: MenuViewModel?
    private let presenter: IMenuPresenter
    private let citiesView: CitiesView
        
    init(presenter: IMenuPresenter) {
        citiesView = CitiesView()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGreyColor
        setupViews()
        presenter.viewLoaded()
    }
}

//MARK: - PrivateFunctions
private extension MenuViewController {
    func setupViews() {
        citiesView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(citiesView)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifire)
        collectionView.register(MenuSectionsCell.self,
                                forSupplementaryViewOfKind: MenuSectionsCell.kindSectionHeader,
                                withReuseIdentifier: MenuSectionsCell.identifire)
        collectionView.register(BannersCell.self,
                                forSupplementaryViewOfKind: BannersCell.kindSectionHeader,
                                withReuseIdentifier: BannersCell.identifire)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            citiesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            citiesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            citiesView.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: citiesView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = menuViewModel {
            return viewModel.menuItem.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifire, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        if let viewModel = menuViewModel {
            let menuItem = viewModel.menuItem[indexPath.item]
            cell.configureWith(menuItemViewModel: menuItem)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = menuViewModel else {
            return UICollectionReusableView()
        }
        
        if kind == MenuSectionsCell.kindSectionHeader {
            guard let cell = collectionView.dequeueReusableSupplementaryView(
                    ofKind: MenuSectionsCell.kindSectionHeader,
                    withReuseIdentifier: MenuSectionsCell.identifire,
                    for: indexPath) as? MenuSectionsCell else { return UICollectionReusableView() }
            
            cell.configureWith(viewModels: viewModel.menuSections)
            cell.delegate = self
            return cell
        }
        if kind == BannersCell.kindSectionHeader {
            guard let cell = collectionView.dequeueReusableSupplementaryView(
                    ofKind: BannersCell.kindSectionHeader,
                    withReuseIdentifier: BannersCell.identifire,
                    for: indexPath) as? BannersCell else { return UICollectionReusableView() }
            cell.configureWith(bannersViewModel: viewModel.banners)
            return cell
        }
        return UICollectionReusableView()
    }
}

//MARK: - UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

//MARK: - LayoutSections
private extension MenuViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            return self.menuSection()
        }
    }
    
    private func menuSection() -> NSCollectionLayoutSection {
        let bannerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(180))
        let bannerHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: bannerHeaderSize,
            elementKind: BannersCell.kindSectionHeader,
            alignment: .top)
        bannerHeader.pinToVisibleBounds = false
        bannerHeader.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        bannerHeader.zIndex = 1
        
        let headerSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension: .estimated(58))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MenuSectionsCell.kindSectionHeader,
            alignment: .top)
        header.pinToVisibleBounds = true
        header.zIndex = 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
       
        section.boundarySupplementaryItems = [bannerHeader, header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        return section
       }
    }

//MARK: - IResortsViewController
extension MenuViewController: IMenuViewController {
    func showPizzaViewModel(pizzaViewModels: MenuViewModel) {
        menuViewModel = pizzaViewModels
        collectionView.reloadData()
    }
    
    func scrollViewTo(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
}

//MARK: - MenuSectionsCellDelegate
extension MenuViewController: MenuSectionsCellDelegate {
    func didChooseMenu(index: Int) {
        if let nameSection = menuViewModel?.menuSections[index].name {
            presenter.chooseSection(section: nameSection)
        }
    }
}



