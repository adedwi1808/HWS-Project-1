//
//  ViewController.swift
//  project-1
//
//  Created by Ade Dwi Prayitno on 28/11/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(shareTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items.sorted(by: <) {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
    
    @objc func shareTapped() {
        
        let vc = UIActivityViewController(activityItems: ["Coba Cek Aplikasi Ini, Keren bangettt !!!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.title = "\(indexPath.row + 1)/\(pictures.count)"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

