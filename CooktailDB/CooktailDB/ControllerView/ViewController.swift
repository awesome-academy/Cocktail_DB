import UIKit

final class ViewController: UIViewController {
    private let data = ["Cocktail", "Ordinary%20Drink", "Coffee%20%5C/%20Tea", "Soft%20Drink"]
    private let image = ["Popular", "Ordinary_Drink", "Coffee_Tea", "Soft_Drink_Soda"]
    private var popularCooktail: [Cooktail] = []
    private var softDrinkSoda: [Cooktail] = []
    private var coffeeTea: [Cooktail] = []
    private var ordinaryDrinkCooktail: [Cooktail] = []
    private var categories: [Category] = []
    private var cooktails: [Cooktail] = []
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var favoriteCollectionView: UICollectionView!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    private var currentCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCooktail()
        configSearchBar()
        configCategory()
        configCollectionView()
    }
    private func configCategory() {
        categories = (0..<data.count).map { index in
            return Category(categoryImage: image[index],
                            categoryName: data[index],
                            categoryNumber: index + 1)
        }
    }
    private func configSearchBar() {
        searchBar.delegate = self
    }
    private func configCollectionView() {
        if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        categoryCollectionView.register(
            UINib(nibName: Constant.CategoryCollectionViewConfig.uiNibNameCell, bundle: nil),
            forCellWithReuseIdentifier: Constant.CategoryCollectionViewConfig.cellWithReuseIdentifier)
        if let layout = favoriteCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        favoriteCollectionView.register(
            UINib(nibName: Constant.FavoriteCollectionViewConfig.uiNibNameCell, bundle: nil),
            forCellWithReuseIdentifier: Constant.FavoriteCollectionViewConfig.cellWithReuseIdentifier)
        currentCollectionView = categoryCollectionView
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
    }
    private func fetchCooktail() {
        let toPath = "c="
        let url = Constant.BaseUrl.getApiBaseUrl + "/"
            + Constant.RelativeUrl.getApiRelativeUrl
            + Constant.Endpoint.filter + toPath + "Coffee%20%5C/%20Tea"
            APIManager.shared.request(url: url, type: Cooktails.self, completionHandler: { [weak self] cooktails in
                guard let cooktails = cooktails.cooktails else { return }
                self?.cooktails = cooktails
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.favoriteCollectionView.reloadData()
                }
            }, failureHandler: {
                print("Error fetching API")
            })
        for index in 0..<data.count {
             let getApiUrl = Constant.BaseUrl.getApiBaseUrl + "/"
                + Constant.RelativeUrl.getApiRelativeUrl
                + Constant.Endpoint.filter + toPath + data[index]
            print(getApiUrl)
            APIManager.shared.request(url: getApiUrl, type: Cooktails.self,
                                      completionHandler: { [weak self] cooktails in
                guard let cooktails = cooktails.cooktails else { return }
                switch self?.data[index] {
                case Constant.Category.popular: self?.popularCooktail = cooktails
                case Constant.Category.ordinary: self?.ordinaryDrinkCooktail = cooktails
                case Constant.Category.coffeeTea:
                    self?.coffeeTea = cooktails
                case Constant.Category.softSoda: self?.softDrinkSoda = cooktails
                default:
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.categories[index].categoryNumber = cooktails.count
                    self.categoryCollectionView.reloadData()
                }
            }, failureHandler: {
                print("Error fetching API")
            })
        }
    }
    @IBAction func categorySeeAllTouchUp(_ sender: Any) {
        if let listView = storyboard?.instantiateViewController(
            withIdentifier: Constant.ControllerView.list) as? ListViewController {
            listView.setCategories(categories: categories)
            self.navigationController?.pushViewController(listView, animated: true)
        }
    }
    @IBAction func favoriteSeeAllTouchUp(_ sender: Any) {
        if let listView = storyboard?.instantiateViewController(
            withIdentifier: Constant.ControllerView.list) as? ListViewController {
            listView.setCooktails(cooktails: cooktails)
            self.navigationController?.pushViewController(listView, animated: true)
        }
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == currentCollectionView {
            return data.count
        } else {
            return cooktails.count
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == currentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Constant.CategoryCollectionViewConfig.cellWithReuseIdentifier,
                for: indexPath) as? CategoryViewCellCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(category: categories[indexPath.row])
            return cell
        } else {
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: Constant.FavoriteCollectionViewConfig.cellWithReuseIdentifier,
                    for: indexPath) as? FavoriteCollectionViewCell else {
                    return UICollectionViewCell()
                }
            cell.setData(cooktail: cooktails[indexPath.row])
            return cell
        }
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == currentCollectionView {
            return Constant.CategoryCollectionViewConfig.cellSize
        } else {
            return Constant.FavoriteCollectionViewConfig.cellSize
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == currentCollectionView {
            if let listView = storyboard?.instantiateViewController(
                withIdentifier: Constant.ControllerView.list) as? ListViewController {
                switch data[indexPath.row] {
                case Constant.Category.popular: listView.setCooktails(cooktails: popularCooktail)
                case Constant.Category.ordinary: listView.setCooktails(cooktails: ordinaryDrinkCooktail)
                case Constant.Category.coffeeTea: listView.setCooktails(cooktails: coffeeTea)
                case Constant.Category.softSoda: listView.setCooktails(cooktails: softDrinkSoda)
                default:
                    listView.setCooktails(cooktails: cooktails)
                }
                self.navigationController?.pushViewController(listView, animated: true)
            }
        } else {
            if let detailView = storyboard?.instantiateViewController(
                withIdentifier: Constant.ControllerView.detail) as? DetailCooktailViewController {
                self.navigationController?.pushViewController(detailView, animated: true)
            }
        }
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let toPath = "s="
        guard let text = searchBar.text else { return }
        let url = Constant.BaseUrl.getApiBaseUrl + "/"
                + Constant.RelativeUrl.getApiRelativeUrl
            + Constant.Endpoint.search + toPath + text
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
                print("Error fetching API")
            })
        }
    }
}
