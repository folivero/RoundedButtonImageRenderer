import UIKit

let helloBadge: UIImage? = {
    let renderer = RoundedButtonImageRenderer(
        borderWidth: 0.0,
        borderColor: nil,
        backgroundColor: UIColor.white,
        fillColor: UIColor(red: 51/255, green: 101/255, blue: 138/255, alpha: 1.0),
        margin: 1.0,
        paddingH: 8.0,
        paddingV: 8.0,
        text: "Hello",
        textColor: .white,
        font: UIFont.systemFont(ofSize: 10.0),
        cornerRadius: 6.0)
    return renderer.image
}()

let worldBadge: UIImage? = {
    let renderer = RoundedButtonImageRenderer(
        borderWidth: 0.0,
        borderColor: nil,
        backgroundColor: UIColor.white,
        fillColor: UIColor(red: 246/255, green: 174/255, blue: 45/255, alpha: 1.0),
        margin: 1.0,
        paddingH: 4.0,
        paddingV: 4.0,
        text: "World",
        textColor: .white,
        font: UIFont.systemFont(ofSize: 10.0),
        cornerRadius: 8.0)
    return renderer.image
}()
