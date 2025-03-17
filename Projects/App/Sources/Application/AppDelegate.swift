import UIKit
import Swinject
import MediaKit
import MusicDomain
import AlbumsFeature
import AlbumDetailFeature

class AppDelegate: UIResponder, UIApplicationDelegate {

    static let container = Container()
    var assembler: Assembler!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        assembler = Assembler(
            [
                MediaKitAssembly(),
                MusicDomainAssembly(),
                AlbumsFeatureAssembly(),
                AlbumDetailAssembly()
            ],
            container: AppDelegate.container
        )
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

