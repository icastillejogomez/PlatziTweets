//
//  HomeViewController.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 07/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let CELL_ID = "TweetTableViewCell"
    private var dataSource = [Post]()

    // MARK: - IBOutlets
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.getTweets()
    }
    
    private func setupUI() {
        // Asignamos el data source de la table (lista)
        self.tweetsTableView.dataSource = self // Para poder asignar self al datasource hay que crear una extension de esta clase con UITableViewDataSource
        
        // Registramos nuestra celda (fila) personalizada para usar en la tabla
        self.tweetsTableView.register(UINib(nibName: CELL_ID, bundle: nil), forCellReuseIdentifier: CELL_ID)
    }

    private func getTweets() {
        // Enable spinner
        SVProgressHUD.show()
        
        // Fetch tweets
        SN.get(endpoint: Endpoints.getPosts, onCompletion: self.processPostsRequest)
    }
    
    private func processPostsRequest (response: SNResultWithEntity<[Post], ErrorResponse>) {
        // Disable spinner
        SVProgressHUD.dismiss()
        
        // Handle response
        switch response {
        case .error(let error):
            // Unhandle error
            print(error)
            return NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger).show()
        case .errorResult(let error):
            // Handled error from server
            return NotificationBanner(title: "Error", subtitle: error.error, style: .warning).show()
        case .success(let tweets):
            print("Hemos cargado \(tweets.count) tweets")
            self.dataSource = tweets
            self.tweetsTableView.reloadData()
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    /**
     * Devolvemos el número de filas que tiene toda la tabla (lista)
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    /**
     * Creamos y configuramos la celda (fila) que va a usar nuestra tabla (lista)
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Creamos una celda reusable a partir de nuestro indentificador de celda y la posicion den la lista
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        
        // Configuramos la celda
        if let cell = cell as? TweetTableViewCell {
            cell.setupCell(post: self.dataSource[indexPath.row])
        }
        
        // Deolvemos la celda
        return cell
    }
    
    
}
