import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set custom tab bar
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
        
        // Create the two view controllers
        let firstViewController = ViewController(movieListType: "Latest")
        let secondViewController = ViewController(movieListType: "Popular")
        
        let firstNavController = UINavigationController(rootViewController: firstViewController)
        let secondNavController = UINavigationController(rootViewController: secondViewController)
        
        // Set titles and tab bar images
        firstViewController.tabBarItem = UITabBarItem(
            title: "Now Playing",
            image: UIImage(systemName: "video.fill"),
            tag: 0
        )
        
        secondViewController.tabBarItem = UITabBarItem(
            title: "Popular",
            image: UIImage(systemName: "star.fill"),
            tag: 1
        )
        
        // Add the view controllers to the tab bar controller
        viewControllers = [firstNavController, secondNavController]
        
        // Customize tab bar item appearance
        let appearance = UITabBarItem.appearance()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10)
        ]
        
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
    }
}
