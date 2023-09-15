import UIKit

final class ListViewController: UIViewController {
    private var categories: [Category]?
    private var cooktails: [Cooktail]?
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var listViewCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configCategoryView()
    }
    private func configCategoryView() {
        listViewCollectionView.register(nibName: CategoryViewCellCollectionViewCell.self)
        listViewCollectionView.delegate = self
        listViewCollectionView.dataSource = self
    }
    func setCategories(categories: [Category]) {
        self.categories = categories
    }
    func setCooktails(cooktails: [Cooktail]) {
        self.cooktails = cooktails
    }
}
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let categories = categories {
            return categories.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CategoryViewCellCollectionViewCell.self, indexPath: indexPath)
        if let categories = categories {
            cell.setData(category: categories[indexPath.row])
        }
        return cell
    }
}
extension ListViewController: UICollectionViewDelegateFlowLayout {
}
