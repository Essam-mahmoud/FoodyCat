//
//  UIImageView+Extension.swift
//  DAWAA
//
//  Created by taha hamdi on 6/11/20.
//  Copyright © 2020 taha hamdi. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView {
    
    func loadImageFromUrl (imgUrl : String?,defString:String = "Location") {
            DispatchQueue.main.async() {
            
                 let defualtImage = UIImage(named: defString)
                            if imgUrl == "" || imgUrl == nil
                            {
                                self.image = defualtImage
                                return
                                
                            }
                            let encoding : String = imgUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            guard let url = URL(string: encoding ) else {
                                self.image = defualtImage
                                return
                            }
                //             self.kf.setImage(with: url,placeholder: defualtImage)
                            let processor = DownsamplingImageProcessor(size: self.frame.size)
                                |> RoundCornerImageProcessor(cornerRadius: 0)
                            self.kf.indicatorType = .activity
                    DispatchQueue.main.async() {
                       self.kf.setImage(
                           with: url,
                           placeholder: UIImage(named: defString),
                           options: [
                               .processor(processor),
                               .scaleFactor(UIScreen.main.scale),
                               .transition(.fade(1)),
                               .cacheOriginalImage
                           ])
                       self.layer.masksToBounds = true
                   }
               }
            
            
//            self.kf.setImage(with: url,placeholder: defualtImage)
        }
}



public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

open class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Take photo".localized()) {
            alertController.addAction(action)
        }
//        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll".localized()) {
//            alertController.addAction(action)
//        }
        if let action = self.action(for: .photoLibrary, title: "Photo library".localized()) {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        
        

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {

}

class SetImageWithPlaceholder{
    class func setImage(_ string: String,placeholder:String,myImage:UIImageView) {
       if let string = (string).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
          let url = URL(string: string)
          myImage.kf.indicatorType = .activity
          let processor = DownsamplingImageProcessor(size: myImage.bounds.size)
          myImage.kf.setImage(
              with: url,
              placeholder: UIImage(named: placeholder),
              options: [.processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage])
          {
              result in
              switch result {
              case .success(let value):
                  print("Task done for: \(value.source.url?.absoluteString ?? "")")
              case .failure(let error):
                  print("Job failed: \(error.localizedDescription)")
              }
          }
      }
    }
}


extension UIImageView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
