import UIKit

final class ListViewController: UIViewController {
    private var categories: [Category]?
    private var cooktails: [Cooktail]?
    private var categoryViewList: [Category]?
    private var cooktailViewList: [Cooktail]?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listViewCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configController()
        configSearchBar()
    }

    private func configController() {
        if categories != nil {
            configCategoryView()
        } else if cooktails != nil {
           configCooktail()
        }
    }

    private func configSearchBar() {
        searchBar.delegate = self
    }

    private func configCooktail() {
        cooktailViewList = cooktails
        listViewCollectionView.register(nibName: CooktailCollectionViewCell.self)
        listViewCollectionView.delegate = self
        listViewCollectionView.dataSource = self
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
        } else if let cooktails = cooktailViewList {
            return cooktails.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let categories = categoryViewList {
            let cell = collectionView.dequeueReusableCell(CategoryViewCellCollectionViewCell.self, indexPath: indexPath)
            cell.setData(category: categories[indexPath.row])
            return cell
        } else if let cooktails = cooktailViewList {
            let cell = collectionView.dequeueReusableCell(CooktailCollectionViewCell.self, indexPath: indexPath)
            cell.setData(cooktail: cooktails[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = cooktails {
            let toPath = "i="
            guard let cooktailId = cooktailViewList?[indexPath.row].cooktailId else { return }
            let url = Constant.BaseUrl.getApiBaseUrl + "/"
                + Constant.RelativeUrl.getApiRelativeUrl
                + Constant.Endpoint.lookUp + toPath
                + cooktailId

            if let detailView = storyboard?.instantiateViewController(
                  withIdentifier: Constant.ControllerView.detail) as? DetailCooktailViewController {
                    APIManager.shared.request(url: url,
                                              type: Cooktails.self,
                                              completionHandler: { [weak self] cooktails in
                    guard let cooktails = cooktails.cooktails?[0] else { return }
                    detailView.setCooktail(cooktail: cooktails)
                    DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.pushViewController(detailView, animated: true)
                    }
                  }, failureHandler: {
                  self.popUpErrorAlert(message: "Error fetching data")
                })
              }
        } else if let categoryViewList = categoryViewList {
            let toPath = "c="
            guard let categoryName = categoryViewList[indexPath.row].categoryName else { return }
            let url = Constant.BaseUrl.getApiBaseUrl + "/"
                    + Constant.RelativeUrl.getApiRelativeUrl
                + Constant.Endpoint.filter + toPath
                + categoryName
            
            if let listView = storyboard?.instantiateViewController(
                withIdentifier: Constant.ControllerView.list) as? ListViewController {
                APIManager.shared.request(url: url, type: Cooktails.self, completionHandler: { [weak self] cooktails in
                    guard let cooktails = cooktails.cooktails else { return }
                    listView.setCooktails(cooktails: cooktails)
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.navigationController?.pushViewController(listView, animated: true)
                    }
                }, failureHandler: {
                    self.popUpErrorAlert(message: "Error fetching data")
                })
            }
        }
    }
}
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let cooktails = cooktails {
            if searchText.isEmpty {
                cooktailViewList = cooktails
            } else {
                cooktailViewList = cooktails.filter({ cooktail in
                    guard let name = cooktail.cooktailName else { return false }
                    return name.localizedCaseInsensitiveContains(searchText)
                })
            }
            listViewCollectionView.reloadData()
        } else if let categories = categories {
            if searchText.isEmpty {
                categoryViewList = categories
            } else {
                categoryViewList = categories.filter({ category in
                    guard let name = category.categoryName else { return false }
                    return name.localizedCaseInsensitiveContains(searchText)
                })
            }
            listViewCollectionView.reloadData()
        }
    }
}
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = CGFloat((Constant.CooktailListCell.itemPerRow + 1)) + Constant.CooktailListCell.insetSession.left
        let availableWidth = view.frame.width - padding
        let width = availableWidth / Constant.CooktailListCell.itemPerRow
        return CGSize(width: width, height: Constant.CooktailListCell.cellHeight)
    }
}
