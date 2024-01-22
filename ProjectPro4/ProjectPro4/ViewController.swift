//
//  ViewController.swift
//  ProjectPro4
//
//  Created by Chingiz on 22.01.24.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var images = [ImageClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
        
        let defaults = UserDefaults.standard
        
        if let savedData = defaults.object(forKey: "images") as? Data {
            if let decodedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [ImageClass] {
                images = decodedData
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)   

        
        let image =  images[indexPath.row]
        cell.textLabel?.text = image.name
        
        let path = getDocumentDirectory().appendingPathComponent(image.imageName)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.description()) as? DetailViewController {
            vc.name = images[indexPath.row].name
            vc.imageName = images[indexPath.row].imageName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let imageType = ImageClass(name: "Unknown", imageName: imageName)
        images.append(imageType)
        tableView.reloadData()
        
        dismiss(animated: true)
        addName(imageType)
        save()
        
    }
    
    func addName(_ imageType: ImageClass){
        let ac = UIAlertController(title: "Add name to image", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Ok", style: .default) {
            [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else {return}
            imageType.name = newName
            self?.save()
            self?.tableView.reloadData()
            })
        present(ac, animated: true)
    }
        	 
    
    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: images, requiringSecureCoding: false){
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: "images")
        }
    }
}

