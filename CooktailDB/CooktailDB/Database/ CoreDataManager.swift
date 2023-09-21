import CoreData
import UIKit
final class CoreDataManager {
    static let shared = CoreDataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constant.Database.persistentContainer)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                self.handleCoreDataError(error)
            }
        }
        return container
    }()
    private init() {}
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                self.handleCoreDataError(nserror)
            }
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
