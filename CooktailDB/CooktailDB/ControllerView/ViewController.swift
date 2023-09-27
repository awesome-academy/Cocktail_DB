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
    private var favoriteCooktails: [Cooktail] = []
    private let database = DatabaseManager()
    private var favoriteCooktailList: [CooktailData]?
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var favoriteCollectionView: UICollectionView!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    private var currentCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCooktailInCategory()
        fetchRandomCooktail()
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
    private func fetchFavoriteCooktailDb() {
        fetchDatabase()
        if let favoriteList = favoriteCooktailList {
            favoriteCooktails = (0..<favoriteList.count).map { index in
                return Cooktail(cooktails: favoriteList[index])
            }
        }
    }
    private func configSearchBar() {
        searchBar.delegate = self
    }
    private func configCollectionView() {
        if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        categoryCollectionView.register(nibName: CategoryViewCellCollectionViewCell.self)
        if let layout = favoriteCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        favoriteCollectionView.register(nibName: FavoriteCollectionViewCell.self)
        currentCollectionView = categoryCollectionView
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
    }
    private func fetchDatabase() {
        do {
            favoriteCooktailList = try database.context.fetch(database.fetchRequest)
        } catch {
            self.popUpErrorAlert(message: "Error fetch database")
        }
    }
    private func fetchRandomCooktail() {
        let numberOfRequests = 10
        let dispatchGroup = DispatchGroup()
        for _ in 0..<numberOfRequests {
            let url = Constant.BaseUrl.getApiBaseUrl + "/"
                + Constant.RelativeUrl.getApiRelativeUrl
                + Constant.Endpoint.random
            dispatchGroup.enter()
            APIManager.shared.request(url: url, type: Cooktails.self, completionHandler: { [weak self] cooktails in
                guard let cooktails = cooktails.cooktails else { return }
                if !cooktails.isEmpty {
                    self?.cooktails.append(cooktails[0])
                }
                dispatchGroup.leave()
            }, failureHandler: {
                self.popUpErrorAlert(message: "Error fetching data")
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.favoriteCollectionView.reloadData()
        }
    }
    private func fetchCooktailInCategory() {
        let toPath = "c="
        for index in 0..<data.count {
             let getApiUrl = Constant.BaseUrl.getApiBaseUrl + "/"
                + Constant.RelativeUrl.getApiRelativeUrl
                + Constant.Endpoint.filter + toPath + data[index]
            APIManager.shared.request(url: getApiUrl, type: Cooktails.self,
                                      completionHandler: { [weak self] cooktailList in
                guard let cooktailList = cooktailList.cooktails else { return }
                switch self?.data[index] {
                case Constant.Category.popular: self?.popularCooktail = cooktailList
                case Constant.Category.ordinary: self?.ordinaryDrinkCooktail = cooktailList
                case Constant.Category.coffeeTea:
                    self?.coffeeTea = cooktailList
                case Constant.Category.softSoda: self?.softDrinkSoda = cooktailList
                default:
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.categories[index].categoryNumber = cooktailList.count
                    self.categoryCollectionView.reloadData()
                }
            }, failureHandler: {
                self.popUpErrorAlert(message: "Error fetching data")
            })
        }
    }
    class func instantiateFromStoryboard() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let VCHome = storyboard.instantiateViewController(
            withIdentifier: Constant.ControllerView.home) as? ViewController {
            return VCHome
        }
        return ViewController()
    }
    @IBAction private func categorySeeAllTouchUp(_ sender: Any) {
        if let listView = storyboard?.instantiateViewController(
            withIdentifier: Constant.ControllerView.list) as? ListViewController {
            listView.setCategories(categories: categories)
            self.navigationController?.pushViewController(listView, animated: true)
        }
    }
    @IBAction private func favoriteSeeAllTouchUp(_ sender: Any) {
        fetchFavoriteCooktailDb()
        if let listView = storyboard?.instantiateViewController(
            withIdentifier: Constant.ControllerView.list) as? ListViewController {
            listView.setCooktails(cooktails: favoriteCooktails)
            self.navigationController?.pushViewController(listView, animated: true)
        }
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == currentCollectionView {
            return min(Constant.LimitNumber.categoryCollectionHomeLimit, data.count)
        } else {
            return min(Constant.LimitNumber.cooktailCollectionHomeLimit, cooktails.count)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == currentCollectionView {
            let cell = collectionView.dequeueReusableCell(CategoryViewCellCollectionViewCell.self, indexPath: indexPath)
            cell.setData(category: categories[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(FavoriteCollectionViewCell.self, indexPath: indexPath)
            cell.setData(cooktail: cooktails[indexPath.row])
            return cell
        }
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == currentCollectionView {
            return Constant.CategoryCollectionViewConfig.cellSize
        } else {
            return Constant.FavoriteCollectionViewConfig.cellSize
        }
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == currentCollectionView {
            if let listView = storyboard?.instantiateViewController(
                withIdentifier: Constant.ControllerView.list) as? ListViewController {
                switch data[indexPath.row] {
                case Constant.Category.popular: listView.setCooktails(cooktails: popularCooktail)
                case Constant.Category.ordinary: listView.setCooktails(cooktails: ordinaryDrinkCooktail)
                case Constant.Category.coffeeTea: listView.setCooktails(cooktails: coffeeTea)
                case Constant.Category.softSoda: listView.setCooktails(cooktails: softDrinkSoda)
                default: break
                }
                self.navigationController?.pushViewController(listView, animated: true)
            }
        } else {
            if let detailView = storyboard?.instantiateViewController(
                withIdentifier: Constant.ControllerView.detail) as? DetailCooktailViewController {
                detailView.setCooktail(cooktail: cooktails[indexPath.row])
                navigationController?.pushViewController(detailView, animated: true)
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
            APIManager.shared.request(url: url, type: Cooktails.self,
                                      completionHandler: { [weak self]cooktails in
                guard let cooktails = cooktails.cooktails else { return }
                listView.setCooktails(cooktails: cooktails)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.pushViewController(listView, animated: true)
                }
              }, failureHandler: { self.popUpErrorAlert(message: "Error fetching data") }
            )
        }
    }
}
