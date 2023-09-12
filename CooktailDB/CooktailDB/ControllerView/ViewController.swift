import UIKit

final class ViewController: UIViewController {
    private var cooktails: [Cooktail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCooktail()
    }
    private func fetchCooktail() {
        let url = Constant.BaseUrl.getApiBaseUrl + "/"
            + Constant.RelativeUrl.getApiRelativeUrl
            + Constant.Endpoint.random
            APIManager.shared.request(url: url, type: Cooktails.self, completionHandler: { [weak self] cooktails in
                guard let cooktails = cooktails.cooktails else { return }
                self?.cooktails = cooktails
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if !self.cooktails.isEmpty {
                        let cooktail = self.cooktails[0]
                        print(cooktail)
                    }
                }
            }, failureHandler: {
                print("Error fetching API")
            })
        }
}
