import UIKit

final class ListViewController: UIViewController {
    private var categories: [Category]?
    private var cooktails: [Cooktail]?
    private var categoryViewList: [Category]?
    private var cooktailViewList: [Cooktail]?
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var listViewCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configCategoryView()
        configSearchBar()
    }
    private func configSearchBar() {
        searchBar.delegate = self
    }
    private func configCategoryView() {
        categoryViewList = categories
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
        if let categories = categoryViewList {
            return categories.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CategoryViewCellCollectionViewCell.self, indexPath: indexPath)
        if let categories = categoryViewList {
            cell.setData(category: categories[indexPath.row])
        }
        return cell
    }
}
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listView = storyboard?.instantiateViewController(
            withIdentifier: Constant.ControllerView.list) as? ListViewController {
            navigationController?.pushViewController(listView, animated: true)
        }
    }
}
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            categoryViewList = categories
        } else {
            categoryViewList = categories?.filter({ category in
                guard let name = category.categoryName else { return false }
                return name.localizedCaseInsensitiveContains(searchText)
            })
        }
        listViewCollectionView.reloadData()
    }
}
extension ListViewController: UICollectionViewDelegateFlowLayout {
}
