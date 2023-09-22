//
//  UserProfileViewController.swift
//  SwavishSoftwareAssignment
//
//  Created by Sumayya Siddiqui on 21/09/23.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseStorage

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgProfilePicture: UIImageView!
    @IBOutlet var btnUpdatePhoto: UIButton!
    @IBOutlet var btnSignout: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnUpdatePhoto.layer.cornerRadius = btnUpdatePhoto.frame.size.height/2
        btnSignout.layer.cornerRadius = 8
        imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.size.height/2
        
        imgProfilePicture.image = UIImage(named: "Logo")
        
        if let user = Auth.auth().currentUser, let email = user.email {
            print("User ID: \(user.uid)")
            print("Current User: \(String(describing: Auth.auth().currentUser))")
            
            let name = email.split(separator: "@").first ?? ""
            lblName.text = "Hi \(name)!"
            
            // Fetch the profile image URL from the database and set it
            let dbReference = Database.database().reference()
            dbReference.child("users").child(user.uid).child("profileImageURL").observeSingleEvent(of: .value) { [weak self] (snapshot) in
                if let imageURLString = snapshot.value as? String, let imageURL = URL(string: imageURLString) {
                    print("Got imageURL from database: \(imageURLString)")
                    self?.imgProfilePicture.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Logo"), options: .refreshCached)
                } else {
                    print("Failed to get imageURL from database.")
                }
            }
        } else {
            print("Failed to get user ID or email.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image selected.")
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        imgProfilePicture.image = selectedImage
        
        uploadProfilePicture(image: selectedImage)
    }
           
    func uploadProfilePicture(image: UIImage) {
          guard let imageData = image.jpegData(compressionQuality: 0.8) else {
              print("Failed to convert image to data.")
              return
          }
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Failed to get user ID.")
            return
        }
        print("User ID: \(userId)") // Add this line to check if the user ID is correctly obtained
        
          let storageReference = Storage.storage().reference().child("profile_pictures").child("\(userId).jpg")
          storageReference.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
              if let error = error {
                  print("Failed to upload to Firebase Storage: \(error.localizedDescription)")
                  return
              }
              
              storageReference.downloadURL { (url, error) in
                  guard let downloadURL = url else {
                      print("Failed to get download URL: \(error?.localizedDescription ?? "Unknown Error")")
                      return
                  }
                  
                  print("Download URL obtained: \(downloadURL.absoluteString)")
                  
                  let dbReference = Database.database().reference()
                  dbReference.child("users").child(userId).updateChildValues(["profileImageURL": downloadURL.absoluteString]) { (error, ref) in
                      if let error = error {
                          print("Failed to set database value: \(error.localizedDescription)")
                      } else {
                          print("Saved image URL to the database successfully!")
                          self?.imgProfilePicture.image = image
                      }
                  }
              }
          }
      }
           
    
    @IBAction func btnUpdatePhotoTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func btnSignoutTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
    

    
    
