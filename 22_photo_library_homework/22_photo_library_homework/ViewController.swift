import UIKit

class ViewController: UIViewController {
    
    private enum Source {
        case camera
        case library
    }
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourImageView: UIImageView!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    
    private var tappedImage: UIImageView?
    private var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageViews = [firstImageView, secondImageView, thirdImageView, fourImageView]
        
        for imageView in imageViews {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView!.addGestureRecognizer(tapGestureRecognizer)
            imageView!.isUserInteractionEnabled = true
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        tappedImage = tapGestureRecognizer.view as? UIImageView
        
        showChoose { [weak self] source in
            guard let source = source else { return }
            
            let picker = UIImagePickerController()
            picker.delegate = self
            
            switch source {
            case .camera:
                picker.sourceType = .camera
                picker.cameraCaptureMode = .photo
            case .library:
                picker.sourceType = .photoLibrary
            }
            
            self?.present(picker, animated: true)
            self?.imagePicker = picker
        }
        
    }
    
    private func showChoose(choosen: @escaping (Source?) -> Void) {
        let alert = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                choosen(.camera)
            })
        }
        alert.addAction(UIAlertAction(title: "Library", style: .default) { _ in
            choosen(.library)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            choosen(nil)
        })
        
        present(alert, animated: true)
    }
    
    private func setTextLabelWithAttributes (number: String, text: String, color: UIColor, label: UILabel) {
        
        let attrString = NSMutableAttributedString()
        let numberAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30),
            .foregroundColor: UIColor.white
        ]
        let numberString = NSAttributedString(string: number, attributes: numberAttrs)

        let textAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: color
        ]
        let textString = NSAttributedString(string: text, attributes: textAttrs)
        
        attrString.append(numberString)
        attrString.append(textString)
        
        label.backgroundColor = .black
        label.attributedText = attrString
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image picked.")

        let image = info[.originalImage] as! UIImage
        tappedImage?.image = image
        
        switch tappedImage {
        case firstImageView:
            setTextLabelWithAttributes(number: "1", text: "first", color: .yellow, label: firstLabel)
        case secondImageView:
            setTextLabelWithAttributes(number: "2", text: "second", color: .green, label: secondLabel)
        case thirdImageView:
            setTextLabelWithAttributes(number: "3", text: "third", color: .blue, label: thirdLabel)
        case fourImageView:
            setTextLabelWithAttributes(number: "4", text: "four", color: .red, label: fourLabel)
        default:
            print("-1")
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        picker.dismiss(animated: true)
    }
}
