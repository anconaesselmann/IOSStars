import UIKit

class ViewController: UIViewController {
    var stars:Stars!
    override func viewDidLoad() {
        super.viewDidLoad()
        stars = Stars(center: view.center)
        stars.starName = "starAlt"
        stars.nbrStars = 10
        stars.marked = 2
        stars.shaded = 5
        self.view.addSubview(stars)
        
    }
    @IBOutlet weak var starsIB: Stars!
    @IBAction func setToHalfAction(sender: AnyObject) {
        stars.setStarsAnimated(10)
    }

    @IBAction func incrementAction(sender: AnyObject) {
        stars.incrementWithAnimation()
        starsIB.incrementWithAnimation()
    }
    @IBAction func decrementAction(sender: AnyObject) {
        stars.decrementWithAnimation()
        starsIB.decrementWithAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

