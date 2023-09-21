import Foundation
import UIKit
import CoreData
final class DatabaseManager {
    static let database = DatabaseManager()
    var fetchRequest: NSFetchRequest<CooktailData> = CooktailData.fetchRequest()
    var context = CoreDataManager.shared.persistentContainer.viewContext
    func fetch() -> [CooktailData] {
        var favoriteUsers: [CooktailData] = []
        do {
            let fetchFavoriteUsers = try context.fetch(fetchRequest) as [CooktailData]?
            if let fetchFavoriteUsers = fetchFavoriteUsers {
                favoriteUsers = fetchFavoriteUsers
            }
        } catch {
            handleCoreDataError(error)
        }
        return favoriteUsers
    }
    func checkFavorite(cooktailTarget: Cooktail) -> CooktailData? {
        let fetchRequest: NSFetchRequest<CooktailData> = CooktailData.fetchRequest()
        do {
            let favouriteCooktails = try context.fetch(fetchRequest)
            guard let favoriteCooktail = favouriteCooktails
                    .filter({($0 as AnyObject).cooktailId == cooktailTarget.cooktailId})
                    .first else { return nil}
            return favoriteCooktail
        } catch {
            handleCoreDataError(error)
            return nil
        }
    }
    private func handleCoreDataError(_ error: Error) {
            let alertController = UIAlertController(title: "Lỗi",
                                                    message: "Có lỗi xảy ra khi làm việc với dữ liệu.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            if let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                currentWindow.rootViewController?.present(alertController, animated: true, completion: nil)
            }
    }
}
