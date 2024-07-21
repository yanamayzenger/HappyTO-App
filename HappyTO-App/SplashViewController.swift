
import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.alpha = 0.0
        UIView.animate(withDuration: 2.0, animations: {
            self.logoImageView.alpha = 1.0
        }) { _ in
            self.perform(#selector(self.showHomeScreen), with: nil, afterDelay: 2.0)
        }
    }

    @objc func showHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: "HomeViewController")
        homeVC.modalTransitionStyle = .crossDissolve
        self.present(homeVC, animated: true, completion: nil)
    }
}
