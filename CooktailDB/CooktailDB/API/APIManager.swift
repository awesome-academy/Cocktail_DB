import Foundation
import UIKit
struct APIManager {
    static let shared = APIManager()
        func request <T: Decodable>(url: String,
                                    type: T.Type,
                                    completionHandler: @escaping(T) -> Void,
                                    failureHandler: @escaping () -> Void) {
            guard let safityUrl = URL(string: url) else {
                failureHandler()
                return
            }
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: safityUrl) { data, _, error in
                if error != nil {
                    failureHandler()
                    return
                }
                guard let data = data else {
                    failureHandler()
                    return
                }
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completionHandler(result)
                } catch {
                    failureHandler()
                }
            }

            task.resume()
        }
    func getImg(url: String, completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        let getImgTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    completionHandler(UIImage(data: data))
                }
            }
        }
        getImgTask.resume()
    }
}
