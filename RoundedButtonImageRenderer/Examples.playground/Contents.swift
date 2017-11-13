import UIKit
import PlaygroundSupport
import RoundedButtonImageRenderer

let helloBadge: UIImage? = {
    return RoundedButtonImageRenderer.renderImage(
        text: "Hello",
        layout: RoundedButtonImageRenderer.LayoutSpecs(
            cornerRadius: 6.0,
            borderWidth: 4.0,
            margin: 1.0,
            paddingH: 8.0,
            paddingV: 8.0,
            font: .systemFont(ofSize: 22.0)),
        colors: RoundedButtonImageRenderer.ColorSpecs(
            border: .lightGray,
            background:.white,
            fill: .gray,
            text: .white)
    )
}()

let worldBadge: UIImage? = {
    return RoundedButtonImageRenderer.renderImage(
        text: "World",
        layout: RoundedButtonImageRenderer.LayoutSpecs(
            cornerRadius: 8.0,
            borderWidth: 0.0,
            margin: 1.0,
            paddingH: 4.0,
            paddingV: 4.0,
            font: .boldSystemFont(ofSize: 25.0)),
        colors: RoundedButtonImageRenderer.ColorSpecs(
            border: nil,
            background:.white,
            fill: .blue,
            text: .white)
    )
}()


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: helloBadge)
        imageView.frame = CGRect(
            x: 50.0,
            y: 50.0,
            width: helloBadge!.size.width,
            height: helloBadge!.size.height
        )
        view.addSubview(imageView)

        let imageView2 = UIImageView(image: worldBadge)
        imageView2.frame = CGRect(
            x: 200.0,
            y: 90.0,
            width: worldBadge!.size.width,
            height: worldBadge!.size.height
        )
        view.addSubview(imageView2)

        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
