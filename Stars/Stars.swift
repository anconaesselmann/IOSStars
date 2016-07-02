import Foundation
import UIKit

@IBDesignable class Stars: UIView {
    @IBInspectable var marked:Int {
        didSet {
            if marked >= 0 {
                setStars()
            }
        }
    }
    @IBInspectable var nbrStars:Int {
        didSet {
            if nbrStars >= 0 {
                setStars()
            }
        }
    }
    var stars = [UIImageView]()
    
    var prerequisite = false
    
    func setStars() {
        guard prerequisite == true else {
            prerequisite = true
            return
        }
        if stars.count > 0 {
            for star in stars {
                star.removeFromSuperview()
            }
            stars = [UIImageView]()
        }
        for i in 0.stride(to: marked, by: 1) {
            let image = UIImage(named: "starDark")
            let size:CGSize = CGSize(width: image!.size.width, height: image!.size.height)
            let origin = CGPoint(x: CGFloat(i) * size.width, y: 0)
            let imageView = UIImageView.init(frame: CGRect(origin: origin, size: size))
            imageView.image = image
            stars.append(imageView)
            self.insertSubview(imageView, atIndex: 0)
        }
        for i in marked.stride(to: nbrStars, by: 1) {
            let image = UIImage(named: "starLight")
            let size:CGSize = CGSize(width: image!.size.width, height: image!.size.height)
            let origin = CGPoint(x: CGFloat(i) * size.width, y: 0)
            let imageView = UIImageView.init(frame: CGRect(origin: origin, size: size))
            imageView.image = image
            stars.append(imageView)
            self.insertSubview(imageView, atIndex: 0)
        }
        self.frame.size.width = stars[0].image!.size.width * CGFloat(nbrStars)
        self.frame.size.height = stars[0].image!.size.height
    }
    func incrementWithAnimation() {
        guard marked < nbrStars else {return}
        let prevSize = stars[marked].frame.size
        let position = stars[marked].center
        let newStar = UIImage(named: "starDark")
        let newStarImageView = UIImageView.init(frame: CGRect(origin: position, size: CGSize(width: 0.0, height: 0.0)))
        newStarImageView.image = newStar
        insertSubview(newStarImageView, atIndex: 0)
        bringSubviewToFront(newStarImageView)
        UIView.animateWithDuration(
            0.5,
            animations: {
                newStarImageView.frame.size = CGSize(width: prevSize.width * 1.5, height:  prevSize.height * 1.5)
                newStarImageView.center = position
            },
            completion: { [unowned self] success in
                self.stars[self.marked].removeFromSuperview()
                self.stars[self.marked] = newStarImageView
                self.marked += 1
            }
        )
    }
    func decrementWithAnimation() {
        guard marked > 0 else {return}
        let prevSize = stars[marked - 1].frame.size
        let position = stars[marked - 1].center
        UIView.animateWithDuration(
            0.5,
            animations: { [unowned self] in
                self.stars[self.marked - 1].frame.size = CGSize(width: prevSize.width * 0.5, height:  prevSize.height * 0.5)
                self.stars[self.marked - 1].center = position
            },
            completion: { [unowned self] success in
                self.marked -= 1
            }
        )
        
    }
    func releaseResources() {
        for star in stars {
            star.removeFromSuperview()
        }
    }
    
    
    init(center:CGPoint) {
        self.nbrStars = -1
        self.marked   = -1
        let size:CGSize = CGSize(width: 0,height: 0)
        super.init(frame: CGRect(origin: center, size: size))
    }
    required init?(coder aDecoder: NSCoder) {
        marked   = -1
        nbrStars = -1
        stars = [UIImageView]()
        super.init(coder: aDecoder)
    }

}